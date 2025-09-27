//
//  AIEditingTextExample.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

struct EditingTextExample: View {
    @State private var isEditing = false
    @State private var text = EditingTextExample.placeholder
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Editing Text")
                .aitext()
                .padding(.top, 40)
            
            Text(text)
                .aiEditingText(when: $isEditing)
                .padding(.horizontal)
            
            HStack {
                Button("Reset") {
                    isEditing = false
                    text = EditingTextExample.placeholder
                }.buttonStyle(.bordered)
                
                Spacer()
                
                Button("Start Editing") {
                    isEditing = true
                    
                    
                }.buttonStyle(.borderedProminent)
            }
            .padding(10)
            Spacer()
        }
        .padding()
    }
    
    private static var placeholder = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus congue maximus venenatis. Pellentesque urna mi, rutrum a leo vitae, tincidunt bibendum urna. Etiam et mauris metus. Suspendisse quam metus, mollis ut pulvinar aliquet, lacinia ut neque. Nam est lectus, pulvinar a consectetur ac, cursus non augue. Etiam diam purus, egestas vitae pellentesque vel, volutpat vitae lacus. Phasellus sem neque, tempus nec cursus ac, lobortis sit amet nisl. Etiam egestas facilisis dolor. Mauris maximus lacus vel ligula dignissim, quis gravida dolor consectetur. Etiam efficitur mi tellus, et congue libero euismod finibus. Pellentesque elementum vitae mauris sit amet semper. Proin placerat viverra quam, eget hendrerit leo consequat ut."
}

#Preview {
    EditingTextExample()
} 
