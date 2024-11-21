import SwiftUI

struct PDFContactSection: View {
    var name: String
    var desgination: String
    var address: String
    var phone: String
    var body: some View {
        VStack(alignment: .leading) {
            SSTextNormal(text: name, fontSize: 14)
            SSTextNormal(text: desgination, fontSize: 14)
            SSTextNormal(text: address, fontSize: 14)
            SSTextNormal(text: phone, fontSize: 14)
            
        }
    }
}

