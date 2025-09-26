//
//  AISuggestionBubbleExample.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

struct SuggestionExample: View {
    @State private var isSuggestionPresented = false
    
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
            VStack(spacing: 100) {
                Text("AI Suggestion Bubble")
                    .aitext()
                    .padding(.top, 40)
                
                VStack(spacing: 30) {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidunt ut labore et dolore magna aliqua.")
                        .aiSuggestionBubble(
                            isPresented: $isSuggestionPresented,
                            text: "How can I help you today?",
                            systemIcon: "apple.intelligence"
                        )
                        .padding()
                    
                    Button("Toggle") {
                        self.isSuggestionPresented.toggle()
                    }
                    .buttonStyle(.glass)
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    SuggestionExample()
} 
