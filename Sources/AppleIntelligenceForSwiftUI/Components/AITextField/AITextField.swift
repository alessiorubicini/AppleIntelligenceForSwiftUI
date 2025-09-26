//
//  AITextField.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

/// A text field styled to closely resemble the input fields used by Apple for interacting with Siri and Apple Intelligence.
public struct AITextField: View {
    
    @Binding var text: String
    var placeholder: String
    var action: (() -> Void)?
    
    @State private var rotation: Double = 0

    /// Creates an `AITextField`.
    ///
    /// - Parameters:
    ///   - text: A binding to the field's text.
    ///   - placeholder: The placeholder string displayed when the field is empty. Defaults to an empty string.
    ///   - action: An optional closure invoked when tapping the trailing action button. When `nil`, no button is shown.
    public init(
        text: Binding<String>,
        placeholder: String = "",
        action: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.action = action
    }

    public var body: some View {
        HStack {
            Image(systemName: "apple.intelligence")
                .font(.system(size: 20))
                .foregroundStyle(Gradient(colors: [.purple, .red, .orange, .blue, .cyan]))
            
            TextField(placeholder, text: $text)
                .padding([.top, .bottom], 5)
                .textFieldStyle(PlainTextFieldStyle())
            
            Spacer()
            if let action {
                Button(action: action) {
                    Image(systemName: "arrow.up.circle")
                        .foregroundStyle(Gradient(colors: [.purple, .red, .orange, .blue, .cyan]))
                }
                .font(.system(size: 25))
                .buttonStyle(ScaleOnPressButtonStyle())
            }

        }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(uiColor: .systemBackground))
            )
            .cornerRadius(25)
            .background(
                TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { context in
                    let t = context.date.timeIntervalSinceReferenceDate
                    let phase = t * 0.25
                    let dynamicColors: [Color] = [0, 1, 2, 3, 4, 5, 6].map { i in
                        let base = Double(i) / 6.0
                        let hue = (base + (sin(phase * 0.9 + base * .pi * 2) * 0.08) + 1).truncatingRemainder(dividingBy: 1)
                        let sat = 0.8 + 0.15 * sin(phase * 0.7 + base * .pi)
                        let bri = 1.0
                        return Color(hue: hue, saturation: sat, brightness: bri)
                    }
                    let angle = Angle.degrees((sin(phase * 1.2) * 120) + 180)
                    let blur = 12 + CGFloat((sin(phase * 0.8) * 0.5 + 0.5) * 16)
                    let opacity = 0.28 + 0.22 * (0.5 + 0.5 * sin(phase * 1.1 + .pi / 4))

                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                AngularGradient(
                                    gradient: Gradient(colors: dynamicColors + [dynamicColors.first ?? .blue]),
                                    center: .center,
                                    angle: angle
                                )
                            )
                            .scaleEffect(1.06)
                            .blur(radius: blur)
                            .opacity(opacity)
                            .shadow(color: .purple.opacity(0.25), radius: 12, x: 0, y: 0)
                            .shadow(color: .blue.opacity(0.18), radius: 12, x: 0, y: 0)
                            .shadow(color: .red.opacity(0.15), radius: 12, x: 0, y: 0)
                    }
                }
            )
        
            .glassEffect()
            
    }
}

private struct ScaleOnPressButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

#Preview {
    VStack {
        AITextField(text: .constant(""), placeholder: "Ask Siri...", action: {})
            .padding()
    }
}
