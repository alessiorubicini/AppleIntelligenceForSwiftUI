//
//  AIText.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 19/06/25.
//


import SwiftUI

private struct AIText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .bold, design: .rounded))
            .foregroundStyle(
                LinearGradient(
                    colors: [
                        Color(red: 1.0, green: 0.45, blue: 0.22), // Orange
                        Color(red: 0.91, green: 0.22, blue: 0.62), // Pink
                        Color(red: 0.36, green: 0.56, blue: 1.0)  // Blue
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

extension View {
    public func aitext() -> some View {
        self.modifier(AIText())
    }
}

#Preview {
    Label("Summarize", systemImage: "text.append")
    .aitext()
}
