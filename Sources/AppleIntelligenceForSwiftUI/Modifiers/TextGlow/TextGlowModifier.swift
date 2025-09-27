//
//  AnimatedGradientTextView.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 26/09/25.
//

import SwiftUI

private struct TextGlowModifier: ViewModifier {
    @State private var animate = false
    let colors: [Color]
    let duration: Double
    
    func body(content: Content) -> some View {
        ZStack {
            // The gradient that flows under the text
            LinearGradient(
                colors: colors,
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: UIScreen.main.bounds.width * 8.9, height: 400)
            .offset(x: animate ? UIScreen.main.bounds.width * -3.4 : UIScreen.main.bounds.width * 4)
            .animation(
                .linear(duration: duration).repeatForever(autoreverses: false),
                value: animate
            )
            .mask(content)
            .onAppear {
                self.animate = true
            }
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
