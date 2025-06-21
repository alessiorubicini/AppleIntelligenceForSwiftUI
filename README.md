<div align="center">
  <img width="300" height="300" src="/Resources/Icon.png" alt="Package Logo">
  <h1><b>Apple Intelligence for SwiftUI</b></h1>
  <p>
    A Swift package providing SwiftUI components and modifiers designed to bring Apple Intelligence-style UI effects and animations to your applications.
    <br>
  </p>
</div>

<div align="center">
  <a href="https://swift.org">
    <img src="https://img.shields.io/badge/Swift-6.0-orange.svg" alt="Swift Version">
  </a>
  <a href="https://www.apple.com/ios/">
    <img src="https://img.shields.io/badge/iOS-26%2B-blue.svg" alt="iOS">
  </a>
  <a href="https://www.apple.com/macOS/">
    <img src="https://img.shields.io/badge/macOS-26%2B-blue.svg" alt="iOS">
  </a>
  <a href="https://www.apple.com/watchOS/">
    <img src="https://img.shields.io/badge/watchOS-26%2B-blue.svg" alt="iOS">
  </a>
  <a href="https://www.apple.com/tvOS/">
    <img src="https://img.shields.io/badge/tvOS-26%2B-blue.svg" alt="iOS">
  </a>
  <a href="https://www.apple.com/visionOS/">
    <img src="https://img.shields.io/badge/visionOS-26%2B-blue.svg" alt="iOS">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT">
  </a>
</div>

> [!WARNING]  
> This package is still in development and may not work as intended.


![Package Preview](/Resources/Preview.png)

## Features

### Available Components
- [AIImagePlaceholder](Sources/AppleIntelligenceForSwiftUI/Components/AIImagePlaceholder): Animated placeholder for AI image generation states.
- [AIProgressView](Sources/AppleIntelligenceForSwiftUI/Components/AIProgressView): Animated row of bouncing dots for loading/progress indication.
- [AISuggestionBubble](Sources/AppleIntelligenceForSwiftUI/Components/AISuggestionBubble): Stylish bubble for displaying AI-generated suggestions (inline or popover).
- [AITextField](Sources/AppleIntelligenceForSwiftUI/Components/AITextField): Custom text field with glowing border, ideal for AI prompts.

### Available Modifiers
- [AIText](Sources/AppleIntelligenceForSwiftUI/Modifiers/AIText): Gradient, bold, rounded text style for titles and highlights.
- [AIGlowEffect](Sources/AppleIntelligenceForSwiftUI/Modifiers/AIGlowEffect): Animated, colorful glowing border for any view.
- [AIFullScreenGlow](Sources/AppleIntelligenceForSwiftUI/Modifiers/AIFullScreenGlow): Full-screen animated, colorful glowing effect similar to the Siri one.
- [AIEditingText](Sources/AppleIntelligenceForSwiftUI/Modifiers/AIEditingText): Applies a scanning and bouncing animation to Text to indicate AI-driven editing.

## Installation
Add the package to your Xcode project using Swift Package Manager:
```swift
.package(url: "https://github.com/alessiorubicini/AppleIntelligenceForSwiftUI.git", from: "1.0.0")
```

## Support
Compatible with iOS, macOS, watchOS, tvOS and visionOS 26.0 and beyond.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.


