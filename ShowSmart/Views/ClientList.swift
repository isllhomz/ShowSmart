import SwiftUI

struct ClientList: View {
    @StateObject private var clientsVM = ClientsVM()
    @Binding var path: NavigationPath
    var body: some View {
        ZStack {
            if clientsVM.clients.isEmpty {
                EmptyView(title: "No Clients Added Yet",
                          description: "Add clients from home screen to share property showings.")
            } else {
                List {
                    ForEach(clientsVM.clients.sorted(by: { $0.date > $1.date })) { client in
                        
                        ClientCell(type: .client(client))
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                            .padding(.vertical, 2)
                            .swipeActions(content: {
                                Button(role: .destructive) {
                                    clientsVM.deleteClient(client)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            })
                            .onTapGesture {
                                path.append(client)
                            }
                        
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Clients")
                .navigationDestination(for: ClientModel.self) { clinet in
                    PropertiesList(path: $path, client: clinet)
                }
            }
        }
        .onAppear {
            clientsVM.getClients()
        }
    }
}

