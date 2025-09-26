//
//  AITextRevealRenderer.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 26/09/25.
//

import Foundation
import SwiftUI

struct AITextRevealRenderer: TextRenderer {
    var elapsedTime: TimeInterval
    var totalDuration: TimeInterval
    var enableGlint: Bool = false
    var showRingEdge: Bool = true
    // Wavefront shimmer parameters
    var shimmerBand: Double = 0.12        // thickness of the bright band at the front (in normalized radius)
    var shimmerMaxOpacity: Double = 0.7   // peak opacity of the shimmer (brighter)
    var shimmerBlur: Double = 0.6         // slightly crisper shimmer
    var shimmerPulseSpeed: Double = 8.0   // faster temporal shimmer modulation

    var animatableData: Double {
        get { elapsedTime }
        set { elapsedTime = newValue }
    }

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        let clampedT = max(0, min(1, totalDuration == 0 ? 1 : elapsedTime / totalDuration))

        // Linear progression to avoid cubic bounce
        let easedT = clampedT

        // Use character-based radial reveal to avoid any line stepping
        drawRadialByCharacter(layout: layout, easedT: easedT, in: &context)
    }

    private func drawRadialByCharacter(layout: Text.Layout, easedT: Double, in ctx: inout GraphicsContext) {
        // Build a 2D collection of glyph slices for (line, column) addressing
        var lineSlices: [[Text.Layout.RunSlice]] = []
        lineSlices.reserveCapacity(layout.count)
        for line in layout {
            var row: [Text.Layout.RunSlice] = []
            for run in line { for slice in run { row.append(slice) } }
            lineSlices.append(row)
        }
        let totalLines = lineSlices.count
        guard totalLines > 0 else { return }
        let maxCols = max(1, lineSlices.map { $0.count }.max() ?? 1)

        // Radial reveal parameters in normalized grid space (x in [0,1], y in [0,1])
        // Origin at top-center: (0.5, 0.0)
        let centerX: Double = 0.5
        let centerY: Double = 0.0

        // Pass 1: compute max distance (Euclidean) so the animation fully covers content
        var maxDist: Double = 0
        for (lineIndex, row) in lineSlices.enumerated() {
            let yNorm: Double = totalLines > 1 ? Double(lineIndex) / Double(totalLines - 1) : 0.0
            for (colIndex, _) in row.enumerated() {
                let xNorm: Double = maxCols > 1 ? Double(colIndex) / Double(maxCols - 1) : 0.5
                let dx = xNorm - centerX
                let dy = yNorm - centerY
                // Euclidean metric without anisotropy or bias
                let d = hypot(dx, dy)
                // No crest deformation in maxDist to avoid oscillatory overreach
                if d > maxDist { maxDist = d }
            }
        }

        // Include a small overshoot by softness to ensure full opacity at end
        let maxRadius: Double = max(0.001, maxDist)
        let softness: Double = 0.12 // width of the transition edge
        let radius: Double = easedT * (maxRadius + softness)
        

        // Subtle ring shimmer at the reveal frontier
        let ringWidth: Double = 0.10

        for (lineIndex, row) in lineSlices.enumerated() {
            let yNorm: Double = totalLines > 1 ? Double(lineIndex) / Double(totalLines - 1) : 0.0
            for (colIndex, slice) in row.enumerated() {
                let xNorm: Double = maxCols > 1 ? Double(colIndex) / Double(maxCols - 1) : 0.5
                let dx = xNorm - centerX
                let dy = yNorm - centerY
                // Distance metric for the wavefront (Euclidean, circular front)
                let dist = hypot(dx, dy)

                // Smooth edge reveal: opacity ramps from 0 to 1 across [radius - softness, radius]
                let t = smoothstep(radius - softness, radius, dist)
                let opacity = 1 - t

                var copy = ctx
                copy.opacity = opacity
                copy.draw(slice)

                // White shimmering highlight right at the wavefront
                let delta = abs(dist - radius)
                if delta < shimmerBand {
                    // Peak at the center of the band, falling off to edges
                    let falloff = 1 - (delta / shimmerBand)
                    // Gentle time-based pulse so it shimmers
                    let pulse = 0.85 + 0.15 * sin(elapsedTime * shimmerPulseSpeed)
                    let strength = max(0, min(1, falloff)) * pulse
                    var hctx = ctx
                    hctx.opacity = strength * shimmerMaxOpacity
                    hctx.addFilter(.colorMultiply(.white))
                    hctx.addFilter(.blur(radius: shimmerBlur))
                    hctx.draw(slice)
                }

                // Optional faint ring highlight at the reveal edge (disabled by default)
                if showRingEdge {
                    let ring = max(0, 1 - (delta / ringWidth))
                    if ring > 0.001 {
                        var sctx = ctx
                        sctx.opacity = ring * 0.45
                        sctx.addFilter(.colorMultiply(.white))
                        sctx.addFilter(.blur(radius: 0.6))
                        sctx.draw(slice)
                    }
                }

                // Optional glint: a tighter, faster moving ring
                if enableGlint {
                    let glintRadius = (easedT * 1.6).truncatingRemainder(dividingBy: 1) * maxRadius
                    let gDelta = abs(dist - glintRadius)
                    let gRing = max(0, 1 - (gDelta / (ringWidth * 0.45)))
                    if gRing > 0.001 {
                        var gctx = ctx
                        gctx.opacity = gRing * 0.35
                        gctx.addFilter(.colorMultiply(.white))
                        gctx.addFilter(.blur(radius: 0.8))
                        gctx.draw(slice)
                    }
                }
            }
        }
    }

    private func smoothstep(_ edge0: Double, _ edge1: Double, _ x: Double) -> Double {
        let t = max(0, min(1, (x - edge0) / (edge1 - edge0)))
        return t * t * (3 - 2 * t)
    }
}

// MARK: - Text modifier driving the animation

private struct AIAnimatedTextModifier: ViewModifier {
    var duration: TimeInterval = 0.8
    var enableGlint: Bool = true

    @State private var time: TimeInterval = 0

    func body(content: Content) -> some View {
        content
            .textRenderer(
                AITextRevealRenderer(
                    elapsedTime: time,
                    totalDuration: duration,
                    enableGlint: enableGlint
                )
            )
            .onAppear {
                withAnimation(.linear(duration: duration)) {
                    time = duration
                }
            }
    }
}

extension Text {
    public func aiAnimatedText(duration: TimeInterval = 0.8, enableGlint: Bool = true) -> some View {
        self.modifier(AIAnimatedTextModifier(duration: duration, enableGlint: enableGlint))
    }
}


