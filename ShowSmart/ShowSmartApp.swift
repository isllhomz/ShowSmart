import SwiftUI

@main
struct ShowSmartApp: App {
    var body: some Scene {
        WindowGroup {
            Splash()
                .onAppear{
                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)

                }
        }
    }
}
