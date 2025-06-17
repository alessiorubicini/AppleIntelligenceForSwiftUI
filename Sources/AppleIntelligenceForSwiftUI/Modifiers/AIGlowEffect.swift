//
//  GlowEffect.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import Foundation
import SwiftUI

struct AIGlowEffect: ViewModifier {
    @State private var rotation: Double = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                AnimatedGlowBorder(rotation: $rotation)
            )
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
    }
}

private struct AnimatedGlowBorder: View {
    @Binding var rotation: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 23)
            .stroke(
                AngularGradient(
                    gradient: Gradient(colors: [
                        .blue, .purple, .red, .orange, .yellow, .green, .cyan, .blue
                    ]),
                    center: .center,
                    angle: .degrees(rotation)
                ),
                lineWidth: 2
            )
            .blur(radius: 5)
            .opacity(0.9)
            .shadow(color: .purple.opacity(0.4), radius: 3)
            .shadow(color: .blue.opacity(0.3), radius: 3)
            .shadow(color: .white.opacity(0.1), radius: 3)
    }
}

extension View {
    func glowEffect() -> some View {
        self.modifier(AIGlowEffect())
    }
}
