//
//  AIProgressView.swift
//  AppleIntelligenceForSwiftUI
//
//  Created by Alessio Rubicini on 17/06/25.
//

import SwiftUI

struct AIProgressView: View {
    @State private var phase: CGFloat = 0
    @State private var timer: Timer? = nil
    let dotCount = 3
    let animationDuration: Double = 1.5
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<dotCount, id: \.self) { index in
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 8, height: 8)
                    .opacity(0.6)
                    .offset(y: calculateOffset(for: index))
            }
        }
        .onAppear {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { _ in
                DispatchQueue.main.async {
                    withAnimation(.linear(duration: 1/60)) {
                        phase += 1 / CGFloat(animationDuration * 60)
                        if phase > 1 { phase -= 1 }
                    }
                }
            }
        }
        .onDisappear {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    private func calculateOffset(for index: Int) -> CGFloat {
        let baseOffset = sin(phase * .pi * 2 + Double(index) * .pi / 2) * 4
        return baseOffset
    }
}

#Preview {
    AIProgressView()
        .padding()
        .preferredColorScheme(.light)
}
