import SwiftUI

struct NotesView: View {
    var title: String = "Notes"
    var height: CGFloat
    @State private var notes: String = ""
    @FocusState private var isTextEditorFocused: Bool
    
    var onEditingFinished: ((String) -> Void)
    
    init(title: String = "", notes: String, height: CGFloat = 100, onEditingFinished: @escaping ((String) -> Void)) {
        self.title = title
        self.height = height
        self.notes = notes
        self.onEditingFinished = onEditingFinished
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
            
            TextEditor(text: $notes)
                .focused($isTextEditorFocused)
                .frame(height: height)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray.opacity(0.7))
                )
                .padding(.horizontal)
                .onChange(of: isTextEditorFocused) { focused in
                    if !focused {
                        onEditingFinished(notes)
                    }
                }
        }
        .onTapGesture {
            isTextEditorFocused = false
        }
    }
}


