//
//  AIChatPromptExample.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date = Date()
}

struct ChatPromptExample: View {
    @State private var prompt: String = ""
    @State private var isLoading: Bool = true
    @State private var messages: [ChatMessage] = [
        ChatMessage(content: "Hi! Do you like this package?", isUser: true),
        ChatMessage(content: "Of course! This Swift package is fantastic! Your apps will look really smart by just looking at them!", isUser: false),
        ChatMessage(content: "Let's reason about it", isUser: true)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(systemName: "apple.intelligence")
                    .font(.system(size: 20))
                    .foregroundStyle(Gradient(colors: [.purple, .red, .orange, .blue, .cyan]))
                Text("Apple Intelligence")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(uiColor: .systemBackground))
            
            Divider()
            
            // Messages area
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if messages.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "apple.intelligence")
                                    .font(.system(size: 40))
                                    .foregroundStyle(Gradient(colors: [.purple, .red, .orange, .blue, .cyan]))
                                Text("How can I help you today?")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 60)
                        }
                        
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                                .padding(.vertical, 5)
                                
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
                .onChange(of: messages.count) { _, _ in
                    if let lastMessage = messages.last {
                        withAnimation(.easeOut(duration: 0.3)) {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            // Input area
            AITextField(text: $prompt, placeholder: "Ask me something...", action: sendPrompt)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    func sendPrompt() {
        guard !prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(content: prompt, isUser: true)
        messages.append(userMessage)
        
        let currentPrompt = prompt
        prompt = ""
        isLoading = true
        
        // Simulate AI response delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let aiResponse = generateAIResponse(for: currentPrompt)
            let aiMessage = ChatMessage(content: aiResponse, isUser: false)
            messages.append(aiMessage)
            isLoading = false
        }
    }
    
    func generateAIResponse(for prompt: String) -> String {
        let responses = [
            "That's an interesting question! Let me think about that...",
            "I understand what you're asking. Here's my perspective on that topic.",
            "Great question! Based on what you've shared, I would suggest...",
            "I can help you with that. Let me break it down for you.",
            "That's a complex topic. Let me explain it step by step."
        ]
        return responses.randomElement() ?? "I'm here to help! What else would you like to know?"
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.content)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.blue)
                        )
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity * 0.7, alignment: .trailing)
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .top, spacing: 0) {
                        Image(systemName: "apple.intelligence")
                            .font(.system(size: 16))
                            .foregroundStyle(Gradient(colors: [.purple, .red, .orange, .blue, .cyan]))
                            .padding(.top, 2)
                        
                        Text(message.content)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color(uiColor: .secondarySystemBackground))
                            )
                            .foregroundColor(.primary)
                    }
                }
                .frame(maxWidth: .infinity * 0.7, alignment: .leading)
                Spacer()
            }
        }
    }
}

struct TypingIndicator: View {
    @State private var animationOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "apple.intelligence")
                    .font(.system(size: 16))
                    .foregroundStyle(Gradient(colors: [.purple, .red, .orange, .blue, .cyan]))
                    .padding(.top, 2)
                
                HStack(spacing: 4) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(Color.secondary)
                            .frame(width: 6, height: 6)
                            .offset(y: animationOffset)
                            .animation(
                                .easeInOut(duration: 0.6)
                                .repeatForever()
                                .delay(Double(index) * 0.2),
                                value: animationOffset
                            )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(uiColor: .secondarySystemBackground))
                )
            }
            Spacer()
        }
        .onAppear {
            animationOffset = -3
        }
    }
}

#Preview {
    ChatPromptExample()
} 
