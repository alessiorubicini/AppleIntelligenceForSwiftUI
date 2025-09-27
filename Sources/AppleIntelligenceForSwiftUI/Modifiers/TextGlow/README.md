# TextGlow

## Overview
`TextGlow` is a SwiftUI modifier that creates an animated gradient effect flowing across text, commonly used to indicate that an AI model is currently reasoning or processing. The effect features a smooth linear gradient that continuously moves across the text, creating a visual indication of active thinking or processing.

## Preview
![TextGlow Preview](./TextGlow-Preview.gif)

## Usage
Apply the `.textGlow()` modifier to any SwiftUI text view to create the animated gradient effect.

```swift
import AppleIntelligenceForSwiftUI

struct ContentView: View {
    var body: some View {
        Text("Working on it...")
            .font(.system(size: 40, weight: .bold))
            .textGlow()
    }
}
```

## Customization
By default, the `textGlow` modifier uses a 2-second animation duration and alternates primary colors with opacity variations, creating a shimmering effect similar to the one we find across common generative AI tools like ChatGPT.

You can customize the gradient colors and animation duration:

```swift
Text("Working on it...")
    .textGlow(
        colors: [
            .blue.opacity(0.8),
            .purple.opacity(0.6),
            .pink.opacity(0.4),
            .blue.opacity(0.8)
        ],
        duration: 3.0
    )
```

## Parameters
- `colors`: Array of `Color` values for the gradient effect (default: primary colors with opacity variations)
- `duration`: Animation duration in seconds (default: 2.0)

## Notes
- The effect is particularly effective for indicating AI model reasoning or processing states
- The gradient automatically flows from right to left across the text
- The animation starts automatically when the view appears
- Works best with bold or prominent text styles for maximum visual impact
