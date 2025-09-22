//
//  AIFullScreenGlowEffect.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 22/09/25.
//

import SwiftUI

struct TextPlaceholderExample: View {
    @State private var isGenerating = true
    var body: some View {
        VStack(alignment: .leading, spacing: 36) {
            Text("Text Placeholder Example")
                .aitext()
            
            AITextPlaceholder(isGenerating: isGenerating, lineCount: 4) {
                Text("Anim velit labore ex pariatur nostrud ullamco incididunt eu nostrud duis est. Irure eu enim amet ea ea cillum laborum ut occaecat incididunt.")
                    .font(.body)
                    .foregroundStyle(.primary)
            }
            Button(isGenerating ? "Finish Generation" : "Restart Generation") {
                isGenerating.toggle()
            }
            .buttonStyle(.glass)
        }
        .padding()
    }
}

#Preview {
    TextPlaceholderExample()
}
