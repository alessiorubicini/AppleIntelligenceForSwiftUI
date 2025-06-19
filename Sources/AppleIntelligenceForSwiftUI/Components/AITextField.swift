//
//  AITextField.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

public struct AITextField: View {
    @Binding var text: String
    var placeholder: String

    public init(text: Binding<String>, placeholder: String = "") {
        self._text = text
        self.placeholder = placeholder
    }

    public var body: some View {
        TextField(placeholder, text: $text)
            .padding(5)
            .textFieldStyle(PlainTextFieldStyle())
            .padding(10)
            .background(Color.clear)
            .cornerRadius(8)
            .glowEffect()
            
    }
} 

#Preview {
    VStack {
        AITextField(text: .constant(""), placeholder: "Describe your prompt")
            .padding()
    }
}
