# AISuggestionBubble

## Overview
`AISuggestionBubble` is a SwiftUI component for displaying AI-generated suggestions in a visually appealing bubble. It supports both inline and popover display modes and provides animated appearance and tap feedback.

## Usage
Import the module and use `AISuggestionBubble` in your SwiftUI view, providing the suggestion text and optional display mode or tap handler.

```swift
import AppleIntelligenceForSwiftUI

var body: some View {
    AISuggestionBubble(suggestion: "How can I help you today?", displayMode: .inline)
}
```

## Example
```swift
AISuggestionBubble(suggestion: "Sure, let's meet at 3pm!", displayMode: .popover) {
    print("Suggestion tapped!")
}
```

## Customization
- Choose between `.inline` and `.popover` display modes.
- Provide an `onTap` closure to handle user interaction.
- Style adapts to system appearance and integrates with the `glowEffect` modifier.