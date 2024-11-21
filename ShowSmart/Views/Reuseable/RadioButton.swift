import SwiftUI

struct RadioButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Circle()
                    .stroke(isSelected ? Color(.theme) : Color.gray, lineWidth: 2)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle()
                            .fill(isSelected ? Color(.theme) : Color.clear)
                            .frame(width: 12, height: 12)
                    )
                Text(label)
                    .foregroundColor(Color.primary)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
