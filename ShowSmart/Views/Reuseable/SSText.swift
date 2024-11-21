import SwiftUI

struct SSText: View {
    var text: String
    var fontSize: CGFloat = 16
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(Color(.foreground))
            .font(.custom("Raleway-SemiBold", size: fontSize))
    }
}

