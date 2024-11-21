import SwiftUI

struct PDFLoaderView: View {
    var body: some View {
        VStack {
            ProgressView("Generating PDF, please wait...")
                .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                .font(.headline)
                .padding()
            
            Image(systemName: "doc")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.primary)
                .rotationEffect(.degrees(30))
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: UUID())
                .padding(.top, 20)
        }
        .padding()
        .background(Color(UIColor.systemBackground).opacity(0.9))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
