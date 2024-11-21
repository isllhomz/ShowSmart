import SwiftUI

struct SSTextNormal: View {
    var text: String
    var fontSize: CGFloat = 16
    var weightType: Int = 1
    var alignment: TextAlignment = .leading
    var body: some View {
        Text(text)
            .font(.custom(weightType == 1 ? "Raleway-Regular" : "Raleway-Bold", size: fontSize))
            .multilineTextAlignment(alignment)
    }
}
