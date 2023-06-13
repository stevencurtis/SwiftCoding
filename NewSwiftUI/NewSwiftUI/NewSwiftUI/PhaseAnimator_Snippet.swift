//
//  PhaseAnimator_Snippet.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct PhaseAnimator_Snippet: View {
    @State private var sightingCount = 0

    var body: some View {
        VStack {
            Spacer()
            HappyDog()
                .phaseAnimator(
                    SightingPhases.allCases, trigger: sightingCount
                ) { content, phase in
                    content
                        .rotationEffect(phase.rotation)
                        .scaleEffect(phase.scale)
                } animation: { phase in
                    switch phase {
                    case .shrink: .snappy(duration: 0.1)
                    case .spin: .bouncy
                    case .grow: .spring(
                        duration: 0.2, bounce: 0.1, blendDuration: 0.1)
                    case .reset: .linear(duration: 0.0)
                    }
                }
                .sensoryFeedback(.increase, trigger: sightingCount)
            Spacer()
            Button("There’s One!", action: recordSighting)
                .zIndex(-1.0)
        }
    }

    func recordSighting() {
        sightingCount += 1
    }

    enum SightingPhases: CaseIterable {
        case reset
        case shrink
        case spin
        case grow

        var rotation: Angle {
            switch self {
            case .spin, .grow: Angle(degrees: 360)
            default: Angle(degrees: 0)
            }
        }

        var scale: Double {
            switch self {
            case .reset: 1.0
            case .shrink: 0.75
            case .spin: 0.85
            case .grow: 1.0
            }
        }
    }
}

struct HappyDog: View {
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(.blue.gradient)
            Text("🐶")
                .font(.system(size: 58))
        }
        .clipShape(.rect(cornerRadius: 12))
        .frame(width: 96, height: 96)
    }
}

#Preview {
    PhaseAnimator_Snippet()
}
