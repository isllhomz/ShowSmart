import SwiftUI

struct FloatingButton: View {
    
    var body: some View {
        Circle()
            .frame(width: 80, height: 80)
            .foregroundColor(Color(.brown))
            .shadow(color: Color(.gray), radius: 5, x: 1, y: 1)
            .overlay(content: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .bold()
                    .foregroundStyle(.white)
            })
            .padding()
    }
}

