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
        VStack(spacing: 40) {
            Text("AI Suggestion Bubble")
                .aitext()
                .padding(.top, 40)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullamco laboriosam.")
                .aiSuggestionBubble(isPresented: $isSuggestionPresented, suggestion: "Try asking for a summary!") {
                    print("Suggestion tapped")
                }
            
            Button("Toggle Suggestion") {
                isSuggestionPresented.toggle()
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SuggestionExample()
} 
