//
//  AnimatedGradientTextView.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 26/09/25.
//

import SwiftUI

private struct TextGlowModifier: ViewModifier {
    let colors: [Color]
    let duration: Double

    func body(content: Content) -> some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            let speed = max(0.1, 2.0 / max(0.1, duration))
            let phase = t * speed
            let width = UIScreen.main.bounds.width

            // Organic motion using sin/cos on multiple axes
            let x1 = CGFloat(sin(phase) + sin(phase * 0.37)) * width * 0.9
            let y1 = CGFloat(cos(phase * 0.83)) * 120
            let x2 = CGFloat(cos(phase * 0.51) + sin(phase * 0.22)) * width * 0.6
            let y2 = CGFloat(sin(phase * 0.67)) * 90
            let rot = Angle.degrees(sin(phase * 0.25) * 30 + 150)

            // Opacity gently breathes to help colors fade and replace one another
            let opacityA = 0.35 + 0.25 * (0.5 + 0.5 * sin(phase * 0.7))
            let opacityB = 0.25 + 0.25 * (0.5 + 0.5 * sin(phase * 0.9 + .pi / 3))

            // Layer A: Base gradient from provided colors, slowly hue-rotated
            let layerA = LinearGradient(
                colors: colors,
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: width * 6.0, height: 420)
            .offset(x: x1, y: y1)
            .rotationEffect(rot)
            .hueRotation(.degrees(sin(phase * 40) * 90))
            .opacity(opacityA)

            // Layer B: A complementary angular gradient that morphs continuously
            let dynamicColors: [Color] = [0, 1, 2, 3, 4].map { i in
                let base = Double(i) * 0.18
                let hue = (base + (sin(phase * 0.55 + base * .pi * 2) * 0.12) + 1).truncatingRemainder(dividingBy: 1)
                return Color(hue: hue, saturation: 0.85, brightness: 1.0)
            }

            let layerB = AngularGradient(
                gradient: Gradient(colors: dynamicColors + [dynamicColors.first ?? .white]),
                center: .center,
                angle: .degrees(sin(phase * 18) * 180)
            )
            .frame(width: width * 5.0, height: 480)
            .offset(x: x2, y: y2)
            .blur(radius: 22)
            .opacity(opacityB)

            ZStack {
                layerA
                layerB.blendMode(.screen)
            }
            .mask(content)
        }
    }
}

public extension View {
    func textGlow(
        colors: [Color] = [
            .primary.opacity(0.6), .primary.opacity(0.6),
            .gray.opacity(0.1), .gray.opacity(0.1),
            .primary.opacity(0.6), .primary.opacity(0.6)
        ],
        duration: Double = 2
    ) -> some View {
        self.modifier(TextGlowModifier(colors: colors, duration: duration))
    }
}

#Preview {
    Text("Working on it...")
        .font(.system(size: 40, weight: .bold))
        .textGlow()
        .padding()
}
