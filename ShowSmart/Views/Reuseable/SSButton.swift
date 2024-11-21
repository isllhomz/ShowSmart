import SwiftUI
struct SSButton: View {
    var title: String
    var height: CGFloat = 200
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color(.theme))
            .frame(width: 200, height: height)
            .overlay {
                SSText(text: title, fontSize: 20)
            }
    }
}
