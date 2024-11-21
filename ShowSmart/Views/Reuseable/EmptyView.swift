import SwiftUI

struct EmptyView: View {
    var title: String
    var description: String
    var body: some View {
        VStack(spacing: 8) {
            Image(.logo)
                .resizable()
                .frame(width: 130, height: 100)
            SSTextNormal(text: title, fontSize: 22)
            SSTextNormal(text: description, fontSize: 16, alignment: .center)
            
        }
    }
}
