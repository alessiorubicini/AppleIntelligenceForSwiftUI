//
//  GeneratingTextExample.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 22/09/25.
//

import SwiftUI

struct GeneratingTextExample: View {
    @State private var isGenerating = true
    var body: some View {
        VStack(alignment: .leading, spacing: 36) {
            Text("Generating Text")
                .aitext()
            
            AIGeneratingText(isGenerating: isGenerating, lineCount: 5) {
                Text("Aute esse quis sit. Mollit sunt et occaecat anim minim in. Ea amet reprehenderit aliqua exercitation tempor ad amet occaecat nostrud excepteur. Do dolore dolor sint nostrud eiusmod labore tempor sint. Culpa elit aute irure nostrud.")
                    .font(.body)
                    .foregroundStyle(.primary)
            }
            Button(isGenerating ? "Finish Generation" : "Restart Generation") {
                isGenerating.toggle()
            }
            .buttonStyle(.glass)
        }
        .padding(20)
    }
}

#Preview {
    GeneratingTextExample()
}
