//
//  KeyframeAnimator_Snippet.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct KeyframeAnimator_Snippet: View {
    var body: some View {
        Logo(color: .blue)
        Text("Tap the shape")
    }
}

struct Logo: View {
    var color: Color
    @State private var runPlan = 0

    var body: some View {
        VStack(spacing: 100) {
            KeyframeAnimator(
                initialValue: AnimationValues(), trigger: runPlan
            ) { values in
                LogoField(color: color)
                    .scaleEffect(values.scale)
                    .rotationEffect(values.rotation, anchor: .bottom)
                    .offset(y: values.verticalTranslation)
                    .frame(width: 240, height: 240)
            } keyframes: { _ in
                KeyframeTrack(\.verticalTranslation) {
                    SpringKeyframe(30, duration: 0.25, spring: .smooth)
                    CubicKeyframe(-120, duration: 0.3)
                    CubicKeyframe(-120, duration: 0.5)
                    CubicKeyframe(10, duration: 0.3)
                    SpringKeyframe(0, spring: .bouncy)
                }

                KeyframeTrack(\.scale) {
                    SpringKeyframe(0.98, duration: 0.25, spring: .smooth)
                    SpringKeyframe(1.2, duration: 0.5, spring: .smooth)
                    SpringKeyframe(1.0, spring: .bouncy)
                }

                KeyframeTrack(\.rotation) {
                    LinearKeyframe(Angle(degrees:0), duration: 0.45)
                    CubicKeyframe(Angle(degrees: 0), duration: 0.1)
                    CubicKeyframe(Angle(degrees: -15), duration: 0.1)
                    CubicKeyframe(Angle(degrees: 15), duration: 0.1)
                    CubicKeyframe(Angle(degrees: -15), duration: 0.1)
                    SpringKeyframe(Angle(degrees: 0), spring: .bouncy)
                }
            }
            .onTapGesture {
                runPlan += 1
            }
        }
    }

    struct AnimationValues {
        var scale = 1.0
        var verticalTranslation = 0.0
        var rotation = Angle(degrees: 0.0)
    }

    struct LogoField: View {
        var color: Color

        var body: some View {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 48)
                    .fill(.shadow(.drop(radius: 5)))
                    .fill(color.gradient)
            }
        }
    }
}

#Preview {
    KeyframeAnimator_Snippet()
}
