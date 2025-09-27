//
//  AIProgressView.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

public struct AIGeneratingText<Content: View>: View {
	public let isGenerating: Bool
	public let lineCount: Int
	public let lineHeight: CGFloat
	public let lineSpacing: CGFloat
	public let cornerRadius: CGFloat
	public let placeholderColor: Color
	public let highlightColor: Color
	public let content: () -> Content

	@State private var verticalAnimationValue: CGFloat = 1.0
	@State private var stretchScaleY: CGFloat = 1.0
	@State private var jumpOffsetY: CGFloat = 0.0
	@State private var shouldRunReveal: Bool = false
	@State private var revealTime: TimeInterval = 0
	@State private var shouldRunEndShimmer: Bool = false
	
	private let revealDuration: TimeInterval = 0.8

	/// Creates a text placeholder that shows skeleton lines while content is being generated.
	/// When generation completes, the provided content is shown instead.
	///
	/// - Parameters:
	///   - isGenerating: Controls whether the placeholder is visible.
	///   - lineCount: Number of placeholder lines.
	///   - lineHeight: Height for each placeholder line.
	///   - lineSpacing: Spacing between placeholder lines.
	///   - cornerRadius: Corner radius for placeholder lines.
	///   - placeholderColor: Base color for skeleton lines.
	///   - highlightColor: Shimmer highlight color.
	///   - content: The content to render when `isGenerating` is false.
	public init(
		isGenerating: Bool,
		lineCount: Int = 3,
		lineHeight: CGFloat = 15,
		lineSpacing: CGFloat = 8,
		cornerRadius: CGFloat = 2,
		placeholderColor: Color = .gray.opacity(0.25),
		highlightColor: Color = .white.opacity(0.7),
		@ViewBuilder content: @escaping () -> Content
	) {
		self.isGenerating = isGenerating
		self.lineCount = max(1, lineCount)
		self.lineHeight = lineHeight
		self.lineSpacing = lineSpacing
		self.cornerRadius = cornerRadius
		self.placeholderColor = placeholderColor
		self.highlightColor = highlightColor
		self.content = content
	}

	public var body: some View {
		ZStack(alignment: .topLeading) {
			content()
				.opacity(isGenerating ? 0 : 1)
				.modifier(TextRevealApplier(apply: shouldRunReveal, elapsedTime: revealTime, totalDuration: revealDuration))
				.overlay(
					GeometryReader { geometry in
						let height = geometry.size.height
						if shouldRunEndShimmer {
							let progress = max(0, min(1, revealDuration == 0 ? 1 : revealTime / revealDuration))
							let syncedOffsetFactor = -1.0 + (2.0 * progress)
							LinearGradient(
								gradient: Gradient(colors: [
									Color.clear,
									Color.white,
									Color.clear
								]),
								startPoint: .top,
								endPoint: .bottom
							)
							.frame(height: height)
							.offset(y: syncedOffsetFactor * height)
							.mask(content())
						}
					}
				)
			if isGenerating {
				// Use a hidden content overlay so placeholder inherits identical layout and position
				content()
					.hidden()
					.overlay(alignment: .topLeading) { placeholder }
			}
		}
		.scaleEffect(x: 1.0, y: stretchScaleY, anchor: .top)
		.offset(y: jumpOffsetY)
		.onChange(of: isGenerating) { oldValue, newValue in
			// Trigger a brief bottom-anchored vertical stretch when generation completes
			if oldValue == true && newValue == false {
				// Match the generating-start animation parameters for a consistent feel
				stretchScaleY = 1.0
				jumpOffsetY = 20.0
				withAnimation(.spring(response: 0.28, dampingFraction: 0.6, blendDuration: 0)) {
					stretchScaleY = 1.08
					jumpOffsetY = 0.0
				}
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
					withAnimation(.spring(response: 0.35, dampingFraction: 0.5, blendDuration: 0)) {
						stretchScaleY = 1.0
					}
				}
				// Trigger text reveal + one-shot reverse shimmer
				shouldRunEndShimmer = true
				shouldRunReveal = true
				revealTime = 0
				withAnimation(.linear(duration: revealDuration)) {
					revealTime = revealDuration
				}
				DispatchQueue.main.asyncAfter(deadline: .now() + revealDuration) {
					shouldRunReveal = false
					revealTime = 0
					shouldRunEndShimmer = false
				}
			} else if oldValue == false && newValue == true {
				// Entering generating: animate placeholder emergence with upward motion and stretch
				stretchScaleY = 0.96
				jumpOffsetY = 20.0
				withAnimation(.spring(response: 0.28, dampingFraction: 0.6, blendDuration: 0)) {
					stretchScaleY = 1.08
					jumpOffsetY = 0.0
				}
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
					withAnimation(.spring(response: 0.35, dampingFraction: 0.5, blendDuration: 0)) {
						stretchScaleY = 1.0
					}
				}
			}
		}
	}

	private var placeholder: some View {
		let skeleton = VStack(alignment: .leading, spacing: lineSpacing) {
			ForEach(0..<lineCount, id: \.self) { index in
				RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
					.fill(placeholderColor)
					.frame(height: lineHeight)
					.frame(maxWidth: .infinity, alignment: .leading)
					.scaleEffect(x: widthFactor(for: index), y: 1.0, anchor: .leading)
			}
		}
		return skeleton
			.overlay(
				GeometryReader { geometry in
					let height = geometry.size.height
					LinearGradient(
						gradient: Gradient(colors: [
							Color.clear,
						Color.red.opacity(0.5),
						Color.orange.opacity(0.5),
						Color.yellow.opacity(0.5),
						Color.green.opacity(0.5),
						Color.blue.opacity(0.5),
						Color.indigo.opacity(0.5),
						Color.purple.opacity(0.5),
							Color.clear
						]),
						startPoint: .bottom,
						endPoint: .top
					)
					.frame(height: height)
					.offset(y: verticalAnimationValue * height)
					.mask(skeleton)
					.animation(
						Animation.linear(duration: 1.2)
							.repeatForever(autoreverses: false),
						value: verticalAnimationValue
					)
					.onAppear {
						verticalAnimationValue = 1.0
						DispatchQueue.main.async { verticalAnimationValue = -1.0 }
					}
					.onDisappear { verticalAnimationValue = 1.0 }
				}
			)
	}

	private func widthFactor(for index: Int) -> CGFloat {
		// Make all lines full width except the last one
		return index == (lineCount - 1) ? 0.6 : 1.0
	}

	/// Convenience initializer for simple text content.
	public init(
		generatedText: String?,
		isGenerating: Bool,
		lineCount: Int = 3,
		lineHeight: CGFloat = 12,
		lineSpacing: CGFloat = 8,
		cornerRadius: CGFloat = 6,
		placeholderColor: Color = .gray.opacity(0.25),
		highlightColor: Color = .white.opacity(0.7)
	) where Content == Text {
		self.init(
			isGenerating: isGenerating,
			lineCount: lineCount,
			lineHeight: lineHeight,
			lineSpacing: lineSpacing,
			cornerRadius: cornerRadius,
			placeholderColor: placeholderColor,
			highlightColor: highlightColor
		) {
			Text(generatedText ?? "")
		}
	}
}

// Applies AITextRevealRenderer to Text only when `apply` is true; otherwise passes content through.
private struct TextRevealApplier: ViewModifier {
	var apply: Bool
	var elapsedTime: TimeInterval
	var totalDuration: TimeInterval
	
	func body(content: Content) -> some View {
		if apply {
			// Rely on the fact that this modifier is attached to Text
			content.textRenderer(
				AITextRevealRenderer(
					elapsedTime: elapsedTime,
					totalDuration: totalDuration,
					enableGlint: false
				)
			)
		} else {
			content
		}
	}
}

struct AITextPlaceholderPreview: View {
    @State private var isGenerating = true
    var body: some View {
        VStack(spacing: 56) {
            AIGeneratingText(isGenerating: isGenerating, lineCount: 6) {
                Text("Tempor sunt dolor nostrud. Minim ea qui ullamco sunt magna aute fugiat et ullamco pariatur do occaecat duis. Excepteur reprehenderit adipisicing do ea mollit culpa cillum quis anim ea veniam nulla aute officia sunt. Cupidatat velit et ex ut mollit commodo nulla magna mollit incididunt cupidatat velit nulla. Qui sunt consectetur aliquip non..")
                    .font(.body)
                    .foregroundStyle(.primary)
            }
            Button(isGenerating ? "Finish Generation" : "Restart Generation") {
                isGenerating.toggle()
            }
            .buttonStyle(.glass)
            
        }
        .padding()
    }
}

#Preview {
    AITextPlaceholderPreview()
}
