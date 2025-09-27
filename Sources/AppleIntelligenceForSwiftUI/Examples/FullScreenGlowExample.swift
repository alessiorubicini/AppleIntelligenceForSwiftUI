import SwiftUI

struct FullScreenGlowExample: View {
    @State private var isActive = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Screen Glow (like Siri!)")
                .aitext()

            
            Button(isActive ? "Stop AI Action" : "Start AI Action") {
                isActive.toggle()
            }
            .padding(.top, 10)
            .buttonStyle(.glass)

        }
        .padding()
        .aiScreenGlowEffect(isActive: $isActive)

    }
}

#Preview {
    FullScreenGlowExample()
} 
