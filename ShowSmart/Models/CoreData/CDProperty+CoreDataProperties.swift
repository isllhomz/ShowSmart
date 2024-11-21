import Foundation
import CoreData


extension CDProperty {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProperty> {
        return NSFetchRequest<CDProperty>(entityName: "CDProperty")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var date: Date?
    @NSManaged public var details: Data?
    @NSManaged public var toClient: CDClient?

}

extension CDProperty : Identifiable {
    func toProperty() -> PropertyModel {
        return PropertyModel(id: self.id ?? UUID(),
                             name: self.name ?? "",
                             address: self.address ?? "",
                             date: self.date ?? Date(),
                             details: self.details ?? Data(),
                             client: self.toClient?.toClient())
    }
}
