//
//  CoreDataManager.swift
//  ShowSmart
//
//  Created by Naqeeb Ahmed Tahir on 15/10/2024.
//
import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var context = container.viewContext

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Showings")
        container.loadPersistentStores { storeDescription, error in
            guard let error = error else { return }
            print(storeDescription)
        }
        return container
    }()
    
    private init() { }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let data =  try context.fetch(managedObject.fetchRequest()) as? [T] else { return nil }
            return data
        } catch { return nil }
    }
    
    func delete<T: NSManagedObject>(id: UUID, managedObject: T.Type) {
        guard let record = self.getData(byIdentifier: id, managedObject: managedObject)?.first else { return }
        context.delete(record)
        save()
    }
    
    func getData<T: NSManagedObject>(byIdentifier id: UUID, managedObject: T.Type) -> [T]? {
        let request = NSFetchRequest<T>(entityName: String(describing: managedObject))
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            return nil
        }
    }
}
