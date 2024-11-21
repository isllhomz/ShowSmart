import SwiftUI

enum CellType {
    case client(ClientModel)
    case propery(PropertyModel)
}

struct ClientCell: View {
    var type: CellType
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.theme)
            .frame(height: 100)
            .overlay {
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color(.foreground))
                        .padding(.trailing)
                    
                    VStack(alignment: .leading) {
                        switch type {
                        case .client(let client):
                            SSText(text: client.name)
                            SSText(text: client.email)
                            SSText(text: client.phone)
                        case .propery(let property):
                            SSText(text: property.address)
                            SSText(text: property.date.formatted(date: .abbreviated, time: .omitted))
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        switch type {
                        case .client(let client):
                            SSText(text: client.date.formatted(date: .numeric, time: .omitted))
                            SSText(text: client.date.formatted(date: .omitted, time: .shortened))
                        case .propery(let property):
                            SSText(text: property.date.formatted(date: .omitted, time: .shortened))
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
    }
}
