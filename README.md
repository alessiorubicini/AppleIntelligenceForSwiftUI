# Apple Intelligence For SwiftUI

A Swift package providing SwiftUI components and modifiers designed to bring Apple Intelligence-style UI effects and animations to your applications.

## Features
- Animated Placeholders for AI-generated images
- Suggestion Bubbles with popover and inline display
- Custom Text Fields with glowing effects
- Animated Progress Indicators
- Reusable View Modifiers for glowing borders and gradient title text

## Documentation

### Available Components
- [AIImagePlaceholder](Sources/AppleIntelligenceForSwiftUI/Components/AIImagePlaceholder) – Animated placeholder for AI image generation states.
- [AIProgressView](Sources/AppleIntelligenceForSwiftUI/Components/AIProgressView) – Animated row of bouncing dots for loading/progress indication.
- [AISuggestionBubble](Sources/AppleIntelligenceForSwiftUI/Components/AISuggestionBubble) – Stylish bubble for displaying AI-generated suggestions (inline or popover).
- [AITextField](Sources/AppleIntelligenceForSwiftUI/Components/AITextField) – Custom text field with glowing border, ideal for AI prompts.

## Available Modifiers
- [AIText](Sources/AppleIntelligenceForSwiftUI/Modifiers/AIText) – Gradient, bold, rounded text style for titles and highlights.
- [AIGlowEffect](Sources/AppleIntelligenceForSwiftUI/Modifiers/AIGlowEffect) – Animated, colorful glowing border for any view.

### How To Use

## Installation
Add the package to your Xcode project using Swift Package Manager:
```swift
.package(url: "https://github.com/alessiorubicini/AppleIntelligenceForSwiftUI.git", from: "1.0.0")
```

## Platform Support
Compatible with iOS, macOS, watchOS, tvOS and visionOS 26.0 and beyond.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.