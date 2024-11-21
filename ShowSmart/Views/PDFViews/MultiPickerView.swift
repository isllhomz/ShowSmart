import SwiftUI

struct MultiPickerView<T: Hashable & Comparable>: View {
    @State private var selectedItems: [String: T]
    let title: String
    let options: [String: [T]]
    let onSelectionChange: (String, T) -> Void
    
    init(title: String, options: [String: [T]], initialSelection: [String: T], onSelectionChange: @escaping (String, T) -> Void) {
        self.title = title
        self.options = options
        _selectedItems = State(initialValue: initialSelection)
        self.onSelectionChange = onSelectionChange
        
    }
    
    var body: some View {
        ForEach(sortedKeys(), id: \.self) { key in
            if let keyOptions = options[key] {
                Picker(String(describing: key).dropFirst(2), selection: Binding(
                    get: { selectedItems[key] ?? keyOptions.first! },
                    set: { newValue in
                        selectedItems[key] = newValue
                        onSelectionChange(key, newValue)
                    }
                )) {
                    ForEach(keyOptions, id: \.self) { option in
                        Text("\(option)").tag(option)
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }
    
    func sortedKeys() -> [String] {
        let keys = Array(options.keys.sorted { $0.compare($1, options: .numeric) == .orderedAscending })
        return keys
    }
}



