# AISuggestionBubble

## Overview
`AISuggestionBubble` is a SwiftUI component for displaying AI-generated suggestions in a floating bubble. It supports both inline and popover display modes and provides animated appearance and tap feedback.

## Preview

## Usage
Import the module and use `AISuggestionBubble` in your SwiftUI view, providing the suggestion text and optional display mode or tap handler.

```swift
import AppleIntelligenceForSwiftUI

var body: some View {
    AISuggestionBubble(suggestion: "How can I help you today?", displayMode: .inline)
}
```

## Notes
- Choose between `.inline` and `.popover` display modes.
- Provide an `onTap` closure to handle user interaction.
- Style adapts to system appearance and integrates with the `glowEffect` modifier.
