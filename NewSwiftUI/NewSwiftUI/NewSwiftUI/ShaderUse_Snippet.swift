//
//  ShaderUse_Snippet.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct ShaderUse_Snippet: View {
    @State private var stripeSpacing: Float = 10.0
    @State private var stripeAngle: Float = 0.0

    var body: some View {
        VStack {
            Text(
                """
                \(
                    Text("Furdinand")
                        .foregroundStyle(stripes)
                        .fontWidth(.expanded)
                ) \
                is a good dog!
                """
            )
            .font(.system(size: 56, weight: .heavy).width(.condensed))
            .lineLimit(...4)
            .multilineTextAlignment(.center)
            Spacer()
            controls
            Spacer()
        }
        .padding()
    }

    var stripes: Shader {
        ShaderLibrary.angledFill(
            .float(stripeSpacing),
            .float(stripeAngle),
            .color(.blue)
        )
    }

    @ViewBuilder
    var controls: some View {
        Grid(alignment: .trailing) {
            GridRow {
                spacingSlider
                ZStack(alignment: .trailing) {
                    Text("50.0 PX").hidden() // maintains size
                    Text("""
                        \(stripeSpacing,
                        format: .number.precision(.fractionLength(1))) \
                        \(Text("PX").textScale(.secondary))
                        """)
                        .foregroundStyle(.secondary)
                }
            }
            GridRow {
                angleSlider
                ZStack(alignment: .trailing) {
                    Text("-0.09π RAD").hidden() // maintains size
                    Text("""
                        \(stripeAngle / .pi,
                        format: .number.precision(.fractionLength(2)))π \
                        \(Text("RAD").textScale(.secondary))
                        """)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .labelsHidden()
    }

    @ViewBuilder
    var spacingSlider: some View {
        Slider(
            value: $stripeSpacing, in: Float(10.0)...50.0) {
                Text("Spacing")
            } minimumValueLabel: {
                Image(
                    systemName:
                        "arrow.down.forward.and.arrow.up.backward")
            } maximumValueLabel: {
                Image(
                    systemName:
                        "arrow.up.backward.and.arrow.down.forward")
            }
    }

    @ViewBuilder
    var angleSlider: some View {
        Slider(
            value: $stripeAngle, in: (-.pi / 2)...(.pi / 2)) {
                Text("Angle")
            } minimumValueLabel: {
                Image(
                    systemName: "arrow.clockwise")
            } maximumValueLabel: {
                Image(
                    systemName: "arrow.counterclockwise")
            }
    }
}

// NOTE: create a .metal file in your project and add the following to it:

/*

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4
angledFill(float2 position, float width, float angle, half4 color)
{
    float pMagnitude = sqrt(position.x * position.x + position.y * position.y);
    float pAngle = angle +
        (position.x == 0.0f ? (M_PI_F / 2.0f) : atan(position.y / position.x));
    float rotatedX = pMagnitude * cos(pAngle);
    float rotatedY = pMagnitude * sin(pAngle);
    return (color + color * fmod(abs(rotatedX + rotatedY), width) / width) / 2;
}

 */

#Preview {
    ShaderUse_Snippet()
}
