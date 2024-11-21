import SwiftUI

struct Splash: View {
    @State private var isActive: Bool = false
    @State private var scaleEffect: CGFloat = 0.3
    var body: some View {
        if isActive {
            Home()
        } else {
            Image("logo")
                .resizable()
                .frame(width: 250, height: 200)
                .scaleEffect(scaleEffect)
                .onAppear {
                    withAnimation(.spring(response: 1.2, dampingFraction: 0.5, blendDuration: 0.4)) {
                        scaleEffect = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        isActive = true
                    }
                }
        }
    }
}
