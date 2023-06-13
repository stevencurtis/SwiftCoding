//
//  VisualEffects_Snippet.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct VisualEffects_Snippet: View {
    @State private var dogs: [Dog] = manySampleDogs
    @StateObject private var simulation = Simulation()
    @State private var showFocalPoint = false

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: itemSpacing) {
                ForEach(dogs) { dog in
                    DogCircle(dog: dog, focalPoint: simulation.point)
                }
            }
            .opacity(showFocalPoint ? 0.3 : 1.0)
            .overlay(alignment: .topLeading) {
                DebugDot(focalPoint: simulation.point)
                    .opacity(showFocalPoint ? 1.0 : 0.0)
            }
            .compositingGroup()
        }
        .coordinateSpace(.dogGrid)
        .onTapGesture {
            withAnimation {
                showFocalPoint.toggle()
            }
        }
    }

    var columns: [GridItem] {
        [GridItem(
            .adaptive(
                minimum: imageLength,
                maximum: imageLength
            ),
            spacing: itemSpacing
        )]
    }

    struct DebugDot: View {
        var focalPoint: CGPoint

        var body: some View {
            Circle()
                .fill(.red)
                .frame(width: 10, height: 10)
                .visualEffect { content, proxy in
                    content.offset(position(in: proxy))
                }
        }

        func position(in proxy: GeometryProxy) -> CGSize {
            guard let backgroundSize = proxy.bounds(of: .dogGrid)?.size else {
                return .zero
            }
            let frame = proxy.frame(in: .dogGrid)
            let center = CGPoint(
                x: (frame.minX + frame.maxX) / 2.0,
                y: (frame.minY + frame.maxY) / 2.0
            )
            let xOffset = focalPoint.x * backgroundSize.width - center.x
            let yOffset = focalPoint.y * backgroundSize.height - center.y
            return CGSize(width: xOffset, height: yOffset)
        }
    }

    /// A self-updating simulation of a point bouncing inside a unit square.
    @MainActor
    class Simulation: ObservableObject {
        @Published var point = CGPoint(
            x: Double.random(in: 0.001..<1.0),
            y: Double.random(in: 0.001..<1.0)
        )

        private var velocity = CGVector(dx: 0.0048, dy: 0.0028)
        private var updateTask: Task<Void, Never>?
        private var isUpdating = true

        init() {
            updateTask = Task.detached {
                do {
                    while true {
                        try await Task.sleep(for: .milliseconds(16))
                        await self.updateLocation()
                    }
                } catch {
                    // fallthrough and exit
                }
            }
        }

        func toggle() {
            isUpdating.toggle()
        }

        private func updateLocation() {
            guard isUpdating else { return }
            point.x += velocity.dx
            point.y += velocity.dy
            if point.x < 0 || point.x >= 1.0 {
                velocity.dx *= -1
                point.x += 2 * velocity.dx
            }
            if point.y < 0 || point.y >= 1.0 {
                velocity.dy *= -1
                point.y += 2 * velocity.dy
            }
        }
    }
}

extension CoordinateSpaceProtocol where Self == NamedCoordinateSpace {
    fileprivate static var dogGrid: Self { .named("dogGrid") }
}

private func magnitude(dx: Double, dy: Double) -> Double {
    sqrt(dx * dx + dy * dy)
}

private struct DogCircle: View {
    var dog: Dog
    var focalPoint: CGPoint

    var body: some View {
        ZStack {
            DogImage(dog: dog)
                .visualEffect { content, geometry in
                    content
                        .scaleEffect(contentScale(in: geometry))
                        .saturation(contentSaturation(in: geometry))
                        .opacity(contentOpacity(in: geometry))
                }
        }
    }
}

private struct DogImage: View {
    var dog: Dog

    var body: some View {
        Circle()
            .fill(.shadow(.drop(
                color: .black.opacity(0.4),
                radius: 4,
                x: 0, y: 2)))
            .fill(dog.color)
            .strokeBorder(.secondary, lineWidth: 3)
            .frame(width: imageLength, height: imageLength)
    }
}

extension DogCircle {
    func contentScale(in geometry: GeometryProxy) -> Double {
        guard let gridSize = geometry.bounds(of: .dogGrid)?.size else { return 0 }
        let frame = geometry.frame(in: .dogGrid)
        let center = CGPoint(x: (frame.minX + frame.maxX) / 2.0, y: (frame.minY + frame.maxY) / 2.0)
        let xOffset = focalPoint.x * gridSize.width - center.x
        let yOffset = focalPoint.y * gridSize.height - center.y
        let unitMagnitude =
            magnitude(dx: xOffset, dy: yOffset) / magnitude(dx: gridSize.width, dy: gridSize.height)
        if unitMagnitude < 0.2 {
            let d = 3 * (unitMagnitude - 0.2)
            return 1.0 + 1.2 * d * d * (1 + d)
        } else {
            return 1.0
        }
    }

    func contentOpacity(in geometry: GeometryProxy) -> Double {
        opacity(for: displacement(in: geometry))
    }

    func contentSaturation(in geometry: GeometryProxy) -> Double {
        opacity(for: displacement(in: geometry))
    }

    func opacity(for displacement: Double) -> Double {
        if displacement < 0.3 {
            return 1.0
        } else {
            return 1.0 - (displacement - 0.3) * 1.43
        }
    }

    func displacement(in proxy: GeometryProxy) -> Double {
        guard let backgroundSize
            = proxy.bounds(of: .dogGrid)?.size
        else {
            return 0
        }
        let frame = proxy.frame(in: .dogGrid)
        let center = CGPoint(
            x: (frame.minX + frame.maxX) / 2.0,
            y: (frame.minY + frame.maxY) / 2.0
        )
        let xOffset = focalPoint.x * backgroundSize.width - center.x
        let yOffset = focalPoint.y * backgroundSize.height - center.y
        return magnitude(dx: xOffset, dy: yOffset)
            / magnitude(
                dx: backgroundSize.width,
                dy: backgroundSize.height)
    }
}

private struct Dog: Identifiable {
    let id = UUID()
    var color: Color
}

private let imageLength = 100.0
private let itemSpacing = 20.0
private let possibleColors: [Color] =
    [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
private let manySampleDogs: [Dog] =
    (0..<100).map {
        Dog(color: possibleColors[$0 % possibleColors.count])
    }

#Preview {
    VisualEffects_Snippet()
}
