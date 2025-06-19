# AIText

## Overview
`AIText` is a SwiftUI view modifier that applies a bold, rounded font and a vibrant gradient foreground to text, making it stand out in AI-driven interfaces.

## Usage
Apply the `.aitext()` modifier to any SwiftUI text view to style it with the AIText appearance.

```swift
import AppleIntelligenceForSwiftUI

var body: some View {
    Text("Summarize")
        .aitext()
}
```

## Example
```swift
Label("Summarize", systemImage: "text.append")
    .aitext()
```

## Customization
- The font size, weight, and gradient colors can be adjusted in the source if needed.
- Use on any SwiftUI `Text` or `Label` for a consistent, branded look.