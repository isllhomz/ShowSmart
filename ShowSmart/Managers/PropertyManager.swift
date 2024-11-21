import Foundation

protocol PropertyDelegate {
    func addProperty(_ property: PropertyModel)
    func getAllProperties(id: UUID) -> [PropertyModel]?
}

final class PropertyManager: PropertyDelegate {
    
    func addProperty(_ property: PropertyModel) {
        let cdProperty = CDProperty(context: CoreDataManager.shared.context)
        cdProperty.id = property.id
        cdProperty.name = property.name
        cdProperty.address = property.address
        cdProperty.date = property.date
        cdProperty.details = property.details
        
        if let id = property.client?.id,
           let cdClient = CoreDataManager.shared.getData(byIdentifier: id, managedObject: CDClient.self)?.first {
            cdProperty.toClient = cdClient
        }
        CoreDataManager.shared.save()
    }
    
    func getAllProperties(id: UUID) -> [PropertyModel]? {
        guard let proerties = CoreDataManager.shared.getData(byIdentifier: id, managedObject: CDProperty.self) else { return nil }
        return proerties.map({ $0.toProperty() })
    }
}
