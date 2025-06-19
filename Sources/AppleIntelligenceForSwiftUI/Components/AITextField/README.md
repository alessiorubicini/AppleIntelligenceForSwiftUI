# AITextField

## Overview
`AITextField` is a SwiftUI component that provides a styled text field with a glowing border, ideal for AI prompt input or other user text entry in modern interfaces.

## Usage
Import the module and use `AITextField` in your SwiftUI view, binding it to a `String` and providing an optional placeholder.

```swift
import AppleIntelligenceForSwiftUI

@State private var prompt: String = ""

var body: some View {
    AITextField(text: $prompt, placeholder: "Describe your prompt")
}
```

## Example
```swift
AITextField(text: $prompt, placeholder: "Type your message...")
```

## Customization
- The placeholder text is customizable.
- The glowing border is provided by the `glowEffect` modifier.
- Integrate with your own logic for handling text input.