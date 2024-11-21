import SwiftUI

struct ShowingPDFSection: View {
    var title: String
    var items: [String:String]
    @State private var keys: [String] = []
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(Color(hex: "#2F425A"))
                .frame(height: 30)
                .padding(.horizontal)
                .overlay {
                    Text(title)
                        .font(.custom("Raleway-Regular", size: 14))
                        .foregroundStyle(Color.white)
                }
            
            ForEach(Array(items.keys.sorted { $0.compare($1, options: .numeric) == .orderedAscending }), id: \.self) { key in
                if let value = items[key] {
                    
                    HStack {
                        Circle()
                            .fill(Color(hex: "#2F425A"))
                            .frame(width: 5, height: 5)
                        
                        SSTextNormal(text: key.lowercased() == "notes" ? "Notes" : String(key.dropFirst(2)), fontSize: 14)
                        
                        Spacer()
                        
                        SSTextNormal(text: value, fontSize: 14)
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
        .onAppear {
            keys = items.map { $0.key }
        }
    }
}



