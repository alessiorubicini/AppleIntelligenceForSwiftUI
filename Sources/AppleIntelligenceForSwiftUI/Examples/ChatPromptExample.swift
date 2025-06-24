//
//  AIChatPromptExample.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

struct ChatPromptExample: View {
    @State private var prompt: String = ""
    @State private var isLoading: Bool = false
    @State private var aiResponse: String? = nil
    
    var body: some View {
        VStack(spacing: 24) {
            Text("AI Chat")
                .aitext()
                .padding(.top, 40)
            
            AITextField(text: $prompt, placeholder: "Ask something...")
                .padding(.horizontal)
            
            Button(action: sendPrompt) {
                Text("Send")
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color.accentColor.opacity(0.2))
                    .cornerRadius(10)
            }
            .disabled(isLoading || prompt.isEmpty)
            
            if isLoading {
                AIProgressView()
                    .padding(.top, 20)
            } else if let response = aiResponse {
                Text(response)
                    .aitext()
                    .padding(.top, 20)
            }
            Spacer()
        }
        .padding()
    }
    
    func sendPrompt() {
        guard !prompt.isEmpty else { return }
        isLoading = true
        aiResponse = nil
        // Simulate AI response delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            aiResponse = "AI: \(prompt.reversed())"
            isLoading = false
        }
    }
}

#Preview {
    ChatPromptExample()
} 
