//
//  AIProgressView.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

public struct AITextPlaceholder<Content: View>: View {
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
	@State private var contentShimmerActive: Bool = false
	@State private var contentShimmerValue: CGFloat = -1.0

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
				.overlay(alignment: .topLeading) {
					if !isGenerating && contentShimmerActive {
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
								startPoint: .top,
								endPoint: .bottom
							)
							.frame(height: height)
							.offset(y: contentShimmerValue * height)
							.mask(content())
							.animation(
								Animation.linear(duration: 0.9),
								value: contentShimmerValue
							)
						}
					}
				}
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
				// One-time shimmer on the final content: top -> bottom
				contentShimmerActive = true
				contentShimmerValue = -1.0
				DispatchQueue.main.async { contentShimmerValue = 1.0 }
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
					contentShimmerActive = false
					contentShimmerValue = -1.0
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

struct AITextPlaceholderPreview: View {
    @State private var isGenerating = true
    var body: some View {
        VStack(alignment: .leading, spacing: 56) {
            AITextPlaceholder(isGenerating: isGenerating, lineCount: 4) {
                Text("Anim velit labore ex pariatur nostrud ullamco incididunt eu nostrud duis est. Irure eu enim amet ea ea cillum laborum ut occaecat incididunt.")
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
