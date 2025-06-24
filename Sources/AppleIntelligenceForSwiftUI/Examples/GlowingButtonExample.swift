import SwiftUI


struct GlowingButtonExample: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("AI Action Button")
                .aitext()
                .padding(.top, 40)
            
            Button(action: { print("AI Action performed") }) {
                Text("AI Recommended Action")
                    .padding(.horizontal, 32)
                    .padding(.vertical, 14)
            }
            .glowEffect()
            Spacer()
        }
        .padding()
    } 
}

#Preview {
    GlowingButtonExample()
} 
