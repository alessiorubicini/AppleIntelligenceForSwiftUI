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
    let animationDuration: Double = 1.2
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.accentColor.opacity(0.15))
                .frame(height: 8)
            GeometryReader { geo in
                let width = geo.size.width
                Capsule()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.accentColor.opacity(0.2),
                                Color.accentColor,
                                Color.accentColor.opacity(0.2)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: width * 0.3, height: 8)
                    .offset(x: (width - width * 0.3) * phase)
                    .shadow(color: Color.accentColor.opacity(0.5), radius: 8, x: 0, y: 0)
                    .animation(.easeInOut(duration: animationDuration), value: phase)
            }
            .frame(height: 8)
        }
        .frame(height: 8)
        .onAppear {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { _ in
                DispatchQueue.main.async {
                    phase += 1 / CGFloat(animationDuration * 60)
                    if phase > 1 { phase -= 1 }
                }
            }
        }
        .onDisappear {
            self.timer?.invalidate()
            self.timer = nil
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    AIProgressView()
        .padding()
        .preferredColorScheme(.light)
}
