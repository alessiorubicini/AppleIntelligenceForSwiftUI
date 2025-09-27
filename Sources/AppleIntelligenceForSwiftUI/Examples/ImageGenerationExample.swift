//
//  AIImageGenerationExample.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

struct ImageGenerationExample: View {
    @State private var state: AIImageGenerationState = .idle(prompt: "Describe an image to generate.")
    @State private var prompt: String = "Describe the image to generate."
    
    var body: some View {
        VStack(spacing: 24) {
            Text("AI Image Generator")
                .aitext()
                .padding(.top, 40)
            
            AIImageGeneration(state: state)
                .frame(height: 200)
                .padding(.top, 10)
            
            AITextField(text: $prompt, placeholder: "Describe an image", action: {
                state = .generating
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    state = .generated(image: Image(systemName: "photo"))
                }
            })
                .padding(.horizontal)
            
            Button("Back to Idle") {
                state = .idle(prompt: prompt)
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
