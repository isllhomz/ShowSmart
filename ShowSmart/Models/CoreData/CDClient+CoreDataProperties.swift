import Foundation
import CoreData

extension CDClient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDClient> {
        return NSFetchRequest<CDClient>(entityName: "CDClient")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var date: Date?
    @NSManaged public var toProperty: Set<CDProperty>?

}

// MARK: Generated accessors for toProperty
extension CDClient {

    @objc(addToPropertyObject:)
    @NSManaged public func addToToProperty(_ value: CDProperty)

    @objc(removeToPropertyObject:)
    @NSManaged public func removeFromToProperty(_ value: CDProperty)

    @objc(addToProperty:)
    @NSManaged public func addToToProperty(_ values: Set<CDProperty>)

    @objc(removeToProperty:)
    @NSManaged public func removeFromToProperty(_ values: Set<CDProperty>)

}

extension CDClient : Identifiable {
    func toClient() -> ClientModel {
        var clientProerties: [PropertyModel] = []
        if let proerties = self.toProperty {
            proerties.forEach { property in
                let _property = PropertyModel(id: property.id ?? UUID(),
                                              name: property.name ?? "",
                                              address: property.address ?? "",
                                              date: property.date ?? Date(),
                                              details: property.details ?? Data())
                clientProerties.append(_property)
            }
        }
        
        return ClientModel(id: self.id ?? UUID(),
                           name: self.name ?? "",
                           email: self.email ?? "",
                           phone: self.phone ?? "",
                           date: self.date ?? Date(),
                           properties: clientProerties)
    }
}
