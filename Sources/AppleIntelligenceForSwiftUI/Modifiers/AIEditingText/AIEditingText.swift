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
    @State private var shouldRunReveal: Bool = false
    @State private var revealTime: TimeInterval = 0
    @State private var shouldRunEndShimmer: Bool = false
    
    private let revealDuration: TimeInterval = 0.8
    
    func body(content: Content) -> some View {
        content
            .opacity(isEditing ? 0.5 : 1.0)
            .modifier(TextRevealApplier(apply: shouldRunReveal, elapsedTime: revealTime, totalDuration: revealDuration))
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
            // One-shot reverse-direction shimmer after editing finishes
            .overlay(
                GeometryReader { geometry in
                    let height = geometry.size.height
                    if shouldRunEndShimmer {
                        let progress = max(0, min(1, revealDuration == 0 ? 1 : revealTime / revealDuration))
                        let syncedOffsetFactor = -1.0 + (2.0 * progress)
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
                        .offset(y: syncedOffsetFactor * height)
                        .mask(content)
                    }
                }
            )
            .onChange(of: isEditing) { oldValue, newValue in
                if oldValue == true && newValue == false {
                    // Trigger one-shot reverse shimmer; movement is driven by revealTime
                    shouldRunEndShimmer = true
                    shouldRunReveal = true
                    revealTime = 0
                    withAnimation(.linear(duration: revealDuration)) {
                        revealTime = revealDuration
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + revealDuration) {
                        shouldRunReveal = false
                        revealTime = 0
                        shouldRunEndShimmer = false
                    }
                }
            }
    }
}

// Applies AITextRevealRenderer to Text only when `apply` is true; otherwise passes content through.
private struct TextRevealApplier: ViewModifier {
    var apply: Bool
    var elapsedTime: TimeInterval
    var totalDuration: TimeInterval
    
    func body(content: Content) -> some View {
        if apply {
            // Rely on the fact that this modifier is attached to Text
            content.textRenderer(
                AITextRevealRenderer(
                    elapsedTime: elapsedTime,
                    totalDuration: totalDuration,
                    enableGlint: false
                )
            )
        } else {
            content
        }
    }
}

extension Text {
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
