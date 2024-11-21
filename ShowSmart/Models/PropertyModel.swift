import Foundation

struct PropertyModel: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var address: String
    var date: Date
    var details: Data
    var client: ClientModel?
}
