import SwiftUI

struct Home: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 50) {
                Button {
                    path.append("start")
                } label: {
                    SSButton(title: "Start a Showing")
                }
                
                Button {
                    path.append("add")
                } label: {
                    SSButton(title: "Add a Client")
                }
            }
            .navigationTitle("Home")
            .tint(Color(.red))
            .navigationDestination(for: String.self) { type in
                switch type {
                case "start":
                    ClientList(path: $path)
                case "add":
                    AddClient(path: $path)
                default: EmptyView(title: "", description: "")
                }
            }
        }
    }
}

#Preview {
    Home()
}
