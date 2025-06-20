# AIFullScreenGlow

## Overview
`AIFullScreenGlow` is a SwiftUI view modifier that adds a vibrant, animated glowing border around the entire screen. It is ideal for highlighting content or creating visually engaging, AI-inspired interfaces.

## Usage
Apply the `.fullScreenGlowEffect()` modifier to any SwiftUI view to wrap it with the animated full-screen glow effect.

```swift
import AppleIntelligenceForSwiftUI

var body: some View {
    ZStack {
        Text("Hello, Siri!")
            .font(.largeTitle)
    }
    .fullScreenGlowEffect()
}
```

## Example
```swift
VStack {
    Image(systemName: "sparkles")
        .font(.system(size: 60))
    Text("AI Magic")
        .font(.title)
}
.fullScreenGlowEffect()
```

## Customization
- The glow's gradient colors, animation speed, and border width can be adjusted in the source if needed.
- The effect automatically adapts to the screen size and safe areas.
