//
//  ClientsManager.swift
//  ShowSmart
//
//  Created by Naqeeb Ahmed Tahir on 15/10/2024.
//

import Foundation

protocol ClientsDelegate {
    func fetchClients() -> [ClientModel]?
    func addCleint(_ client: ClientModel)
    func deleteCleint(_ client: ClientModel)
}

final class ClientsManager {
    
}

extension ClientsManager: ClientsDelegate {
    
    func addCleint(_ client: ClientModel) {
        let newClient = CDClient(context: CoreDataManager.shared.context)
        newClient.id = client.id
        newClient.name = client.name
        newClient.date = client.date
        newClient.email = client.email
        newClient.phone = client.phone
        
        CoreDataManager.shared.save()
    }
    
    func fetchClients() -> [ClientModel]? {
        guard let clients = CoreDataManager.shared.fetchData(managedObject: CDClient.self) else { return nil }
        return clients.compactMap { $0.toClient() }
    }
    
    func deleteCleint(_ client: ClientModel) {
        CoreDataManager.shared.delete(id: client.id, managedObject: CDClient.self)
    }
}
