//
//  AISuggestionBubble.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

public struct AISuggestionBubble: View {
    public enum DisplayMode {
        case popover, inline
    }
    
    let suggestion: String
    let displayMode: DisplayMode
    let onTap: (() -> Void)?
    
    @State private var appear = false
    @State private var tapScale: CGFloat = 1.0
    
    public init(suggestion: String, displayMode: DisplayMode = .inline, onTap: (() -> Void)? = nil) {
        self.suggestion = suggestion
        self.displayMode = displayMode
        self.onTap = onTap
    }
    
    public var body: some View {
        Group {
            if displayMode == .popover {
                content
                    .shadow(radius: 10)
                    .transition(.scale.combined(with: .opacity))
            } else {
                content
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                appear = true
            }
        }
        .onDisappear {
            appear = false
        }
    }
    
    private var content: some View {
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
            .scaleEffect((appear ? 1 : 0.95) * tapScale)
            .opacity(appear ? 1 : 0)
            .onTapGesture {
                withAnimation(.spring(response: 0.15, dampingFraction: 0.5)) {
                    tapScale = 0.92
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) {
                        tapScale = 1.0
                    }
                }
                onTap?()
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: appear)
    }
}

#Preview {
    VStack(spacing: 30) {
        AISuggestionBubble(suggestion: "Sure, let's meet at 3pm!", displayMode: .popover) {
            print("Suggestion tapped!")
        }
        AISuggestionBubble(suggestion: "How can I help you today?", displayMode: .inline)
    }
    .padding()
    
} 
