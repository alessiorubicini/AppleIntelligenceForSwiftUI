//
//  AIEditingText.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 25/06/2024.
//

import SwiftUI

private struct AIEditingText: ViewModifier {
    
    @Binding var isEditing: Bool
    @State private var animationValue: CGFloat = 1.0
    @State private var bounceOffset: CGFloat = 0.0
    
    func body(content: Content) -> some View {
        content
            .opacity(isEditing ? 0.5 : 1.0)
            .offset(y: bounceOffset)
            .overlay(
                GeometryReader { geometry in
                    let height = geometry.size.height
                    if isEditing {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.clear,
                                Color.white,
                                Color.clear
                            ]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .frame(height: height)
                        .offset(y: animationValue * height)
                        .mask(content)
                        .animation(
                            isEditing ?
                                Animation.linear(duration: 1.2)
                                    .repeatForever(autoreverses: false) : .default,
                            value: animationValue
                        )
                        .onAppear {
                            animationValue = 1.0
                            DispatchQueue.main.async {
                                animationValue = -1.0
                            }
                        }
                        .onDisappear {
                            animationValue = 1.0
                        }
                    }
                }
            )
            .onChange(of: isEditing) { oldValue, newValue in
                if oldValue == true && newValue == false {
                    withAnimation(.interpolatingSpring(stiffness: 200, damping: 5)) {
                        bounceOffset = 20
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                        withAnimation(.interpolatingSpring(stiffness: 200, damping: 5)) {
                            bounceOffset = 0
                        }
                    }
                }
            }
    }
}

extension View {
    /// Applies an animated editing effect to the view when the specified binding is true.
    ///
    /// This modifier visually indicates the editing state by animating a shimmering white gradient overlay
    /// and reducing the view's opacity while editing. When editing ends, a bounce animation provides subtle feedback.
    ///
    /// - Parameter isEditing: A binding to a Boolean value that controls whether the editing state is active.
    /// - Returns: A view that visually responds to editing transitions with animation and effects.
    ///
    /// Example usage:
    /// ```swift
    /// Text("Editable Text")
    ///     .aiEditingText(when: $isEditing)
    /// ```
    public func aiEditingText(when isEditing: Binding<Bool>) -> some View {
        self.modifier(AIEditingText(isEditing: isEditing))
    }
}

#Preview {
    struct PreviewContainer: View {
        @State private var isEditing = false
        var body: some View {
            VStack(spacing: 50) {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullamco laboriosam.")
                    .aiEditingText(when: $isEditing)
                
                Button(isEditing ? "Finish Editing" : "Start Editing") {
                    isEditing.toggle()
                }
                .buttonStyle(.glass)
                .padding()

            }
            .padding()
        }
    }
    return PreviewContainer()
} 
