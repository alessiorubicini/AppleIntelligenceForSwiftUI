//
//  AIImageGenerationExample.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

struct ImageGenerationExample: View {
    @State private var state: AIImagePlaceholderState = .idle(prompt: "Describe the image to generate.")
    @State private var prompt: String = "A sunset over the mountains"
    
    var body: some View {
        VStack(spacing: 24) {
            Text("AI Image Generator")
                .aitext()
                .padding(.top, 40)
            
            AIImagePlaceholder(state: state)
                .frame(height: 200)
                .padding(.top, 10)
            
            AITextField(text: $prompt, placeholder: "Describe your image...")
                .padding(.horizontal)
            
            HStack(spacing: 16) {
                Button("Back to Idle") {
                    state = .idle(prompt: prompt)
                }//.disabled(self.state == .idle)
                Button("Generate") {
                    state = .generating(prompt: prompt)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        state = .generated(image: Image(systemName: "photo"))
                    }
                }.buttonStyle(.glass)
            }
            .padding(.top, 10)

            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ImageGenerationExample()
} 
