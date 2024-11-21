import Foundation

struct ClientModel: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var email: String
    var phone: String
    var date: Date
    var properties: [PropertyModel]?
}
