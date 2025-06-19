# AIGlowEffect

## Overview
`AIGlowEffect` is a SwiftUI view modifier that adds an animated, colorful glowing border to any view. It is ideal for highlighting interactive or AI-driven UI elements.

## Usage
Apply the `.glowEffect()` modifier to any SwiftUI view to add the animated glow.

```swift
import AppleIntelligenceForSwiftUI

var body: some View {
    Text("Glowing Text")
        .glowEffect()
}
```

## Example
```swift
Button("Continue") {
    // Action
}
.glowEffect()
```

## Customization
- The glow uses a rotating angular gradient for a dynamic effect.
- The border radius and colors can be adjusted in the source if needed.