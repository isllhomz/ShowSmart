import SwiftUI

struct SmartSection: View {
    @Binding var data: ShowingsData?
    var index: String? = nil

    var body: some View {
        Section("\(data?.type ?? "")" + " \(index ?? "")") {
            MultiPickerView(title: data?.type ?? "",
                            options: data?.options ?? [:],
                            initialSelection: data?.selected ?? [:]) { _key,_value in
                updateData(_title: "\(data?.type ?? "")" + " \(index ?? "")", _key: _key, _value: _value)
                
            }
            NotesView(notes: data?.selected["Notes"] ?? "") { updatedNotes in
                updateNotes(_title: "\(data?.type ?? "")" + " \(index ?? "")", updatedNotes: updatedNotes)
            }
        }
    }
    
    func updateData(_title: String, _key: String, _value: String) {
        let NewTitle = _title.last == " " ? String(_title.dropLast()) : _title
        Constants.pdfData.filter({$0.title.lowercased() == NewTitle.lowercased()}).first?.items[_key] = _value
        data?.selected[_key] = _value
    }
    
    func updateNotes(_title: String, updatedNotes: String) {
        let NewTitle = _title.last == " " ? String(_title.dropLast()) : _title
        Constants.pdfData.filter({$0.title.lowercased() == NewTitle.lowercased()}).first?.items["Notes"] = updatedNotes
        data?.selected["Notes"] = updatedNotes
    }
}
