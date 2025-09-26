//
//  AISuggestionBubble.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

/// PreferenceKey to measure content's height
private struct ContentHeightKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

private struct AISuggestionBubble: ViewModifier {
    @Binding var isPresented: Bool
    let text: String
    let systemIcon: String?
    let onTap: (() -> Void)?
    
    @State private var tapScale: CGFloat = 1.0
    @State private var bubbleOffset: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    
    public init(isPresented: Binding<Bool>, text: String, systemIcon: String? = nil, onTap: (() -> Void)? = nil) {
        self._isPresented = isPresented
        self.text = text
        self.systemIcon = systemIcon
        self.onTap = onTap
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                // misura l’altezza del contenuto
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: ContentHeightKey.self, value: proxy.size.height)
                    }
                )
                .onPreferenceChange(ContentHeightKey.self) { height in
                    contentHeight = height
                    bubbleOffset = -height - 12 // 12 è un padding extra opzionale
                }
            
            if isPresented {
                bubbleContent
                    .offset(y: bubbleOffset)
                    .zIndex(1)
                    .transition(.scale.combined(with: .opacity))
                    .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isPresented)
            }
        }
    }
    
    private var bubbleContent: some View {
        HStack {
            if let icon = systemIcon {
                Image(systemName: icon)
            }
            
            Text(text)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
        .scaleEffect(tapScale)
        .accessibilityLabel(Text(text))
        .accessibilityAddTraits(.isButton)
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

extension View {
    /// Adds an AI-generated suggestion bubble overlay to this view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to show the suggestion bubble.
    ///   - suggestion: The suggestion text to display.
    ///   - systemIcon: An optional SF Symbol to show before the text.
    ///   - onTap: An optional closure to run when the bubble is tapped.
    /// - Returns: A view with an AI suggestion bubble overlay.
    public func aiSuggestionBubble(
        isPresented: Binding<Bool>,
        text: String,
        systemIcon: String? = nil,
        onTap: (() -> Void)? = nil
    ) -> some View {
        modifier(AISuggestionBubble(isPresented: isPresented, text: text, systemIcon: systemIcon, onTap: onTap))
    }
}

#Preview {
    struct AISuggestionBubble_Previews: View {
        @State var isPresented = true
        
        var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.orange.opacity(0.3),
                        Color.red.opacity(0.3),
                        Color.purple.opacity(0.3),
                        Color.blue.opacity(0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidunt ut labore et dolore magna aliqua.")
                        .aiSuggestionBubble(
                            isPresented: $isPresented,
                            text: "How can I help you today?",
                            systemIcon: "apple.intelligence"
                        )
                        .padding()
                    
                    Button("Toggle") {
                        self.isPresented.toggle()
                    }
                    .buttonStyle(.glass)
                }
            }
        }
    }
    return AISuggestionBubble_Previews()
}
