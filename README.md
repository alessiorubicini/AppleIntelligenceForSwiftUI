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


![Package Preview](/Resources/Preview.png)

## Features


### Modifiers
- [AIText](Sources/AppleIntelligenceForSwiftUI/Modifiers/AIText): Gradient, bold, rounded text style for titles and highlights.
- [AIScreenGlow](Sources/AppleIntelligenceForSwiftUI/Modifiers/AIScreenGlow): Full-screen animated, colorful glowing effect similar to the Siri one.
- [AIEditingText](Sources/AppleIntelligenceForSwiftUI/Modifiers/AIEditingText): Applies a scanning and bouncing animation to Text to indicate AI-driven editing.
- [AISuggestionBubble](Sources/AppleIntelligenceForSwiftUI/Components/AISuggestionBubble): Stylish bubble for displaying AI-generated suggestions above elements.
- [TextGlow](Sources/AppleIntelligenceForSwiftUI/Modifiers/TextGlow): Adds a glowing effect to text, usually used to show loading states.

### Components
- [AIImageGeneration](Sources/AppleIntelligenceForSwiftUI/Components/AIImageGeneration): Animated placeholder for AI image generation states.
- [AIGeneratingText](Sources/AppleIntelligenceForSwiftUI/Components/AIGeneratingText): Animated text placeholder with shimmer for AI text generation states.
- [AITextField](Sources/AppleIntelligenceForSwiftUI/Components/AITextField): Custom text field with glowing border, ideal for AI prompts.


> **Note:** While this package helps you create Apple Intelligence-style UI, developers should always refer to the [Generative AI section of the Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/generative-ai/) to ensure your app meets Apple's standards for generative AI experiences.


## Installation
Required iOS, macOS, watchOS, tvOS or visionOS 26.0 or above.

Add the package to your Xcode project using Swift Package Manager:
```swift
.package(url: "https://github.com/alessiorubicini/AppleIntelligenceForSwiftUI.git", from: "0.1")
```


## License
Copyright 2025 (©) Alessio Rubicini.

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.


