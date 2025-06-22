//
//  AISuggestionBubble.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

/// A stylized suggestion bubble modifier for displaying AI-generated suggestions overlaying any SwiftUI view.
/// 
/// `AISuggestionBubble` visually highlights a suggestion and displays it as a floating `.popover` bubble with shadow.
/// The bubble features animated appearance/disappearance, a scale-tap effect,
/// and a soft glowing background.
///
/// - Parameters:
///   - isPresented: A binding to a Boolean value that determines whether to show the suggestion bubble.
///   - suggestion: The text to display inside the bubble.
///   - onTap: An optional closure executed when the bubble is tapped. Use this to handle user selection of the suggestion.
///
/// ### Example
/// ```swift
/// @State private var showSuggestion = true
///
/// Text("Hello")
///    .aiSuggestionBubble(isPresented: $showSuggestion, suggestion: "Sure, let's meet at 3pm!") {
///        print("Suggestion tapped!")
///    }
/// ```
public struct AISuggestionBubble: ViewModifier {
    @Binding var isPresented: Bool
    let suggestion: String
    let onTap: (() -> Void)?
    
    @State private var tapScale: CGFloat = 1.0
    
    public init(isPresented: Binding<Bool>, suggestion: String, onTap: (() -> Void)? = nil) {
        self._isPresented = isPresented
        self.suggestion = suggestion
        self.onTap = onTap
    }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            content
            if isPresented {
                bubbleContent
                    .offset(x: 10, y: -50)
                    .zIndex(1)
                    .transition(AnyTransition.scale.combined(with: .opacity).animation(.spring(response: 0.4, dampingFraction: 0.7)))
                    .shadow(radius: 10)
            }
        }
    }
    
    private var bubbleContent: some View {
        Text(suggestion)
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(.systemBackground).opacity(0.95))
            )
            .glowEffect()
            .scaleEffect(tapScale)
            .onTapGesture {
                withAnimation(.spring(response: 0.15, dampingFraction: 0.5)) {
                    tapScale = 0.92
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) {
                        tapScale = 1.0
                        onTap?()
                        isPresented = false
                    }
                }
            }
    }
}

public extension View {
    /// Adds an AI-generated suggestion bubble overlay to this view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to show the suggestion bubble.
    ///   - suggestion: The suggestion text to display.
    ///   - onTap: An optional closure to run when the bubble is tapped.
    /// - Returns: A view with an AI suggestion bubble overlay.
    func aiSuggestionBubble(isPresented: Binding<Bool>, suggestion: String, onTap: (() -> Void)? = nil) -> some View {
        modifier(AISuggestionBubble(isPresented: isPresented, suggestion: suggestion, onTap: onTap))
    }
}

#Preview {
    struct AISuggestionBubble_Previews: View {
        @State var isPresented = true
        
        var body: some View {
            VStack(spacing: 30) {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullamco laboriosam.")
                    .aiSuggestionBubble(isPresented: $isPresented, suggestion: "How can I help you today?")
                    .padding()
                
                Button("Toggle") {
                    self.isPresented.toggle()
                }.buttonStyle(.glass)
            }
            
        }
    }
    return AISuggestionBubble_Previews()
}
