//
//  AIScreenGlow.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 19/06/25.
//

import Foundation
import SwiftUI

private struct AIScreenGlowEffect: ViewModifier {
    @Binding var isActive: Bool
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                content
                AnimatedScreenGlowBorder(size: geometry.size)
                    .opacity(isActive ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5), value: isActive)
                    .allowsHitTesting(false)
            }
        }
        .ignoresSafeArea()
    }
}

private struct AnimatedScreenGlowBorder: View {
    var size: CGSize
    
    var body: some View {
        let dynamicCornerRadius = min(size.width, size.height) * 0.18
        
        TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            let phase = t * 0.25
            let dynamicColors: [Color] = [0, 1, 2, 3, 4, 5, 6].map { i in
                let base = Double(i) / 6.0
                let hue = (base + (sin(phase * 0.9 + base * .pi * 2) * 0.08) + 1).truncatingRemainder(dividingBy: 1)
                let saturation = 0.8 + 0.15 * sin(phase * 0.7 + base * .pi)
                let brightness = 1.0
                return Color(hue: hue, saturation: saturation, brightness: brightness)
            }
            let angle = Angle.degrees((sin(phase * 1.2) * 120) + 180)
            let primaryOpacity = 0.5 + 0.15 * sin(phase * 1.1 + .pi / 4)
            let secondaryOpacity = 0.22 + 0.1 * sin(phase * 0.9 + .pi / 3)
            let tertiaryOpacity = 0.12 + 0.05 * sin(phase * 0.7)
            let blurTertiary: CGFloat = 28 + CGFloat((sin(phase * 0.8) * 0.5 + 0.5) * 16)

            ZStack {
                // Primary glow layer - main colored border
                RoundedRectangle(cornerRadius: dynamicCornerRadius)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: dynamicColors + [dynamicColors.first ?? .blue]),
                            center: .center,
                            angle: angle
                        ),
                        lineWidth: 16
                    )
                    .frame(width: size.width, height: size.height)
                    .blur(radius: 6)
                    .opacity(primaryOpacity)
                    .shadow(color: .purple.opacity(0.2), radius: 8, x: 0, y: 0)
                    .shadow(color: .blue.opacity(0.15), radius: 8, x: 0, y: 0)
                    .shadow(color: .red.opacity(0.12), radius: 8, x: 0, y: 0)
                
                // Secondary glow layer - softer outer glow
                RoundedRectangle(cornerRadius: dynamicCornerRadius)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: dynamicColors + [dynamicColors.first ?? .blue]),
                            center: .center,
                            angle: angle
                        ),
                        lineWidth: 16
                    )
                    .frame(width: size.width, height: size.height)
                    .blur(radius: 10)
                    .opacity(secondaryOpacity)
                
                // Tertiary glow layer - widest diffusion
                RoundedRectangle(cornerRadius: dynamicCornerRadius)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: dynamicColors + [dynamicColors.first ?? .blue]),
                            center: .center,
                            angle: angle
                        ),
                        lineWidth: 40
                    )
                    .frame(width: size.width, height: size.height)
                    .blur(radius: blurTertiary)
                    .opacity(tertiaryOpacity)
            }
            .ignoresSafeArea()
        }
    }
}

extension View {
    public func aiScreenGlowEffect(isActive: Binding<Bool>) -> some View {
        self.modifier(AIScreenGlowEffect(isActive: isActive))
    }
}

#Preview {
    struct AIFullScreenGlowEffect_Previews: View {
        @State var isActive = true
        
        var body: some View {
            VStack(spacing: 30) {
                Text("Hello, Siri!")
                    .font(.largeTitle)
                
                Button("Toggle") {
                    self.isActive.toggle()
                }.buttonStyle(.glass)
            }
            .aiScreenGlowEffect(isActive: $isActive)
        }
    }
    return AIFullScreenGlowEffect_Previews()
}
