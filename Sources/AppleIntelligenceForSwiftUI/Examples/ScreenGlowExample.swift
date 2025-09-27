//
//  ScreenGlowExample.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 22/09/25.
//

import SwiftUI

struct ScreenGlowExample: View {
    @State private var isActive = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Screen Glow (like Siri!)")
                .aitext()

            
            Button(isActive ? "Stop AI Action" : "Start AI Action") {
                isActive.toggle()
            }
            .padding(.top, 10)
            .buttonStyle(.glass)

        }
        .padding()
        .aiScreenGlowEffect(isActive: $isActive)

    }
}

#Preview {
    ScreenGlowExample()
} 
