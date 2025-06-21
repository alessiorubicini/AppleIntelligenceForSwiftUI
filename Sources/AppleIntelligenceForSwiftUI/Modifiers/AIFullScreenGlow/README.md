# AIFullScreenGlow

## Overview
`AIFullScreenGlow` is a SwiftUI view modifier that adds a vibrant, animated glowing border around the entire screen. Since it's almost identical to Apple Intelligence Siri's screen border glow effect, this should be used carefully only to provide a visual feedback for on-going specific intelligent actions, possibly only those involving the interaction with an intelligent agent.

## Preview

## Usage
Apply the `.fullScreenGlowEffect` modifier to any SwiftUI view to wrap it with the animated full-screen glow effect.

```swift
import AppleIntelligenceForSwiftUI

@State var isActive = true

var body: some View {
    VStack(spacing: 30) {
        Text("Hello, Siri!")
            .font(.largeTitle)

        Button("Toggle") {
            self.isActive.toggle()
        }.buttonStyle(.glass)
    }
    .fullScreenGlowEffect(isActive: $isActive)
}

```

## Notes
- The effect automatically adapts to the screen size and safe areas.
- Currently, Apple does not prohibit the use of such an animation in any way in its guidelines. Please note that this may change in the future. Always consult Apple's Human Interface Guidelines.
