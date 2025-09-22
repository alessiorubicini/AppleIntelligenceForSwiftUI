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
    @State private var shouldRunEndShimmer: Bool = false
    @State private var endAnimationValue: CGFloat = -1.0
    @State private var stretchScaleY: CGFloat = 1.0
    @State private var jumpOffsetY: CGFloat = 0.0
    
    func body(content: Content) -> some View {
        content
            .opacity(isEditing ? 0.5 : 1.0)
            .scaleEffect(x: 1.0, y: stretchScaleY, anchor: .top)
            .offset(y: jumpOffsetY)
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
                    } else if shouldRunEndShimmer {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.clear,
                                Color.white,
                                Color.clear
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: height)
                        .offset(y: endAnimationValue * height)
                        .mask(content)
                        .animation(
                            Animation.linear(duration: 0.9),
                            value: endAnimationValue
                        )
                    }
                }
            )
            .onChange(of: isEditing) { oldValue, newValue in
                if oldValue == true && newValue == false {
                    // Stretch and jump when finishing editing (mirrors AITextPlaceholder timing)
                    stretchScaleY = 1.0
                    jumpOffsetY = 20.0
                    withAnimation(.spring(response: 0.28, dampingFraction: 0.6, blendDuration: 0)) {
                        stretchScaleY = 1.08
                        jumpOffsetY = 0.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.5, blendDuration: 0)) {
                            stretchScaleY = 1.0
                        }
                    }
                    // Trigger one-time reverse shimmer when editing ends
                    shouldRunEndShimmer = true
                    endAnimationValue = -1.0
                    DispatchQueue.main.async {
                        endAnimationValue = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        shouldRunEndShimmer = false
                        endAnimationValue = -1.0
                    }
                } else if oldValue == false && newValue == true {
                    // Entering editing: upward motion and subtle stretch
                    stretchScaleY = 0.96
                    jumpOffsetY = 20.0
                    withAnimation(.spring(response: 0.28, dampingFraction: 0.6, blendDuration: 0)) {
                        stretchScaleY = 1.08
                        jumpOffsetY = 0.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.5, blendDuration: 0)) {
                            stretchScaleY = 1.0
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
    /// and reducing the view's opacity while editing. When editing ends, a reverse shimmer effect provides subtle feedback.
    ///
    /// - Parameter isEditing: A binding to a Boolean value that controls whether the editing state is active.
    /// - Returns: A view that visually responds to editing transitions with shimmer effects.
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
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus congue maximus venenatis. Pellentesque urna mi, rutrum a leo vitae, tincidunt bibendum urna. Etiam et mauris metus. Suspendisse quam metus, mollis ut pulvinar aliquet, lacinia ut neque. Nam est lectus, pulvinar a consectetur ac, cursus non augue. Etiam diam purus, egestas vitae pellentesque vel, volutpat vitae lacus. Phasellus sem neque, tempus nec cursus ac, lobortis sit amet nisl. Etiam egestas facilisis dolor. Mauris maximus lacus vel ligula dignissim, quis gravida dolor consectetur. Etiam efficitur mi tellus, et congue libero euismod finibus. Pellentesque elementum vitae mauris sit amet semper. Proin placerat viverra quam, eget hendrerit leo consequat ut.")
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
