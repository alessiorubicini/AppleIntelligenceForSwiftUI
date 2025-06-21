# AIImagePlaceholder

## Overview
`AIImagePlaceholder` is an animated SwiftUI view designed to visually represent the state of an AI image generation process. It provides a smooth, modern placeholder for idle, generating, and generated image states.

## Preview
...

## Usage
Import the module and use `AIImagePlaceholder` in your SwiftUI view, providing the appropriate `AIImagePlaceholderState`.

```swift
import AppleIntelligenceForSwiftUI

@State private var state: AIImagePlaceholderState = .idle(prompt: "Describe the image to generate.")

var body: some View {
    AIImagePlaceholder(state: state)
}
```

## Notes
- The appearance adapts to the state: idle, generating, or generated.
- The prompt text and generated image are customizable via the state.
- Integrate with your AI image generation logic to update the state as needed.
