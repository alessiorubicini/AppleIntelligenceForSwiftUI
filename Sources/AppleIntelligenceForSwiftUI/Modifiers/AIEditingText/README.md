# AIEditingText

## Overview
`AIEditingText` is a SwiftUI view modifier that visually indicates when a text field or view is in an editing state. It applies a subtle opacity change, a moving highlight animation, and a bounce effect when editing ends, making editing states more intuitive and engaging in AI-driven interfaces.

## Usage
Apply the `.aiEditingText(when:)` modifier to any SwiftUI view, passing a `Binding<Bool>` that reflects the editing state.

```swift
import AppleIntelligenceForSwiftUI

@State private var isEditing = false

var body: some View {
    Text("Edit me!")
        .aiEditingText(when: $isEditing)
}
```


## Customization
- The modifier animates a white highlight over the text when `isEditing` is true.
- When editing ends, a bounce effect is triggered for visual feedback.
- You can use this modifier on any SwiftUI `View` to provide a consistent editing experience.
