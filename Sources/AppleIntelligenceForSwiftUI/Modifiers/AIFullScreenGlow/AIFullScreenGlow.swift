//
//  AIFullScreenGlow.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 19/06/25.
//

import Foundation
import SwiftUI

struct AIFullScreenGlowEffect: ViewModifier {
    @State private var rotation: Double = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                content
                AnimatedFullScreenGlowBorder(rotation: $rotation, size: geometry.size)
                    .allowsHitTesting(false)
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
        }
        .ignoresSafeArea()
    }
}

private struct AnimatedFullScreenGlowBorder: View {
    @Binding var rotation: Double
    var size: CGSize
    
    var body: some View {
        let dynamicCornerRadius = min(size.width, size.height) * 0.20
        RoundedRectangle(cornerRadius: dynamicCornerRadius)
            .stroke(
                AngularGradient(
                    gradient: Gradient(colors: [
                        .blue, .purple, .red, .orange, .yellow, .green, .cyan, .blue
                    ]),
                    center: .center,
                    angle: .degrees(rotation)
                ),
                lineWidth: 18
            )
            .frame(width: size.width, height: size.height)
            .blur(radius: 12)
            .opacity(0.85)
            .shadow(color: .purple.opacity(0.4), radius: 10)
            .shadow(color: .blue.opacity(0.3), radius: 10)
            .shadow(color: .white.opacity(0.1), radius: 10)
            .ignoresSafeArea()
    }
}

extension View {
    func fullScreenGlowEffect() -> some View {
        self.modifier(AIFullScreenGlowEffect())
    }
}

#Preview {
    struct AIFullScreenGlowEffect_Previews: View {
        var body: some View {
            ZStack {
                Text("Hello, Siri!")
                    .font(.largeTitle)
            }
            .fullScreenGlowEffect()
        }
    }
    return AIFullScreenGlowEffect_Previews()
}

