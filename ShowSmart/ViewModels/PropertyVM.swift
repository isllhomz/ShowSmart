//
//  ProrttyVM.swift
//  ShowSmart
//
//  Created by Naqeeb Ahmed Tahir on 18/10/2024.
//
import SwiftUI

final class PropertyVM: ObservableObject {
    @Published var Properties: [PropertyModel] = []
    let propertyManager: PropertyDelegate
    
    init(property: PropertyDelegate = PropertyManager()) {
        self.propertyManager = property
    }
}

extension PropertyVM {
    func getAllProperties(id: UUID) {
        Properties = propertyManager.getAllProperties(id: id) ?? []
    }
    
    func addProperty(_ property: PropertyModel) {
        propertyManager.addProperty(property)
    }
}
