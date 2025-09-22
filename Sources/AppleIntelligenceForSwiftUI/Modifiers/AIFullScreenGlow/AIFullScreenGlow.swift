//
//  AIFullScreenGlow.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 19/06/25.
//

import Foundation
import SwiftUI

private struct AIFullScreenGlowEffect: ViewModifier {
    @Binding var isActive: Bool
    @State private var rotation: Double = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                content
                AnimatedFullScreenGlowBorder(rotation: $rotation, size: geometry.size)
                    .opacity(isActive ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5), value: isActive)
                    .allowsHitTesting(false)
            }
            .onAppear {
                if isActive {
                    withAnimation(Animation.linear(duration: 8).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                } else {
                    rotation = 0
                }
            }
            .onChange(of: isActive) { oldValue, newValue in
                if newValue {
                    withAnimation(Animation.linear(duration: 8).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                } else {
                    withAnimation(Animation.easeOut(duration: 0.8)) {
                        rotation = 0
                    }
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
        let dynamicCornerRadius = min(size.width, size.height) * 0.18
        
        ZStack {
            // Primary glow layer - main colored border
            RoundedRectangle(cornerRadius: dynamicCornerRadius)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.8, green: 0.2, blue: 0.9),   // Purple/magenta (top-left)
                            Color(red: 0.4, green: 0.3, blue: 0.9),   // Blue-purple (left)
                            Color(red: 0.9, green: 0.6, blue: 0.2),   // Yellow-orange (bottom)
                            Color(red: 0.9, green: 0.3, blue: 0.4),   // Pink-red (right)
                            Color(red: 0.8, green: 0.2, blue: 0.9)    // Back to purple
                        ]),
                        center: .center,
                        angle: .degrees(rotation)
                    ),
                    lineWidth: 16
                )
                .frame(width: size.width, height: size.height)
                .blur(radius: 6)
                .opacity(0.6)
            
            // Secondary glow layer - softer outer glow
            RoundedRectangle(cornerRadius: dynamicCornerRadius)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.8, green: 0.2, blue: 0.9),
                            Color(red: 0.4, green: 0.3, blue: 0.9),
                            Color(red: 0.9, green: 0.6, blue: 0.2),
                            Color(red: 0.9, green: 0.3, blue: 0.4),
                            Color(red: 0.8, green: 0.2, blue: 0.9)
                        ]),
                        center: .center,
                        angle: .degrees(rotation)
                    ),
                    lineWidth: 16
                )
                .frame(width: size.width, height: size.height)
                .blur(radius: 6)
                .opacity(0.3)
            
            // Tertiary glow layer - widest diffusion
            RoundedRectangle(cornerRadius: dynamicCornerRadius)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.8, green: 0.2, blue: 0.9),
                            Color(red: 0.4, green: 0.3, blue: 0.9),
                            Color(red: 0.9, green: 0.6, blue: 0.2),
                            Color(red: 0.9, green: 0.3, blue: 0.4),
                            Color(red: 0.8, green: 0.2, blue: 0.9)
                        ]),
                        center: .center,
                        angle: .degrees(rotation)
                    ),
                    lineWidth: 40
                )
                .frame(width: size.width, height: size.height)
                .blur(radius: 32)
                .opacity(0.15)
        }
        .ignoresSafeArea()
    }
}

extension View {
    public func aiFullScreenGlowEffect(isActive: Binding<Bool>) -> some View {
        self.modifier(AIFullScreenGlowEffect(isActive: isActive))
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
            .aiFullScreenGlowEffect(isActive: $isActive)
        }
    }
    return AIFullScreenGlowEffect_Previews()
}
