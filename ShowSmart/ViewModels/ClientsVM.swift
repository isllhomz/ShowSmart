//
//  ClientsListVM.swift
//  ShowSmart
//
//  Created by Naqeeb Ahmed Tahir on 15/10/2024.
//

import Foundation

final class ClientsVM: ObservableObject {
    @Published var clients: [ClientModel] = []
    let clientManager: ClientsDelegate
    
    init(client: ClientsDelegate = ClientsManager()) {
        self.clientManager = client
    }
}

extension ClientsVM {
    func getClients() {
        clients = clientManager.fetchClients() ?? []
    }
    
    func addClient(_ client: ClientModel) {
        clientManager.addCleint(client)
    }
    
    func deleteClient(_ client: ClientModel) {
        clientManager.deleteCleint(client)
    }
}
