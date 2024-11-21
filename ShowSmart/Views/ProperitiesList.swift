import SwiftUI

struct PropertiesList: View {
    @StateObject private var propertyVM = PropertyVM()
    @Binding var path: NavigationPath
    var client: ClientModel
    
    var body: some View {
        
        ZStack {
            if let properties = client.properties, !properties.isEmpty {
                ScrollView {
                    ForEach(properties.sorted(by: { $0.date > $1.date })) { property in
                        Button {
                            path.append(1)
                        } label: {
                            ClientCell(type: .propery(property))
                        }
                    }
                }
            } else {
                EmptyView(title: "No Property Found",
                          description: "Click Plus Button to add first property")
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        path.append(1)
                    } label: {
                        FloatingButton()
                    }
                }
                .padding(.trailing)
            }
            .padding(.bottom)
            
        }
        .navigationTitle("Properties")
        .onAppear {
            Constants.selectedClient = client
        }
        .navigationDestination(for: Int.self) { _ in
            PropertyDetails(path: $path)
        }
        
    }
}

