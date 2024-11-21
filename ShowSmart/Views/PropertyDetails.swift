import SwiftUI
enum PreviewType {
    case new, preview, update
}
struct PropertyDetails: View {
    @Binding var path: NavigationPath
    @State private var address: String = ""
    @State private var firstLoad: Bool = true
    @State private var showDynamicSheet = false
    @State private var showAlert = false
    @State private var navigate = false
    @State private var otherNotes = ""
    @State private var otherNotesView: Bool = false
    
    @State private var showings: Showings?
    @State private var showingsData: [ShowingsData]?
    
    @State private var numerOfBedrooms: Int = 4
    @State private var numerOfBathrooms: Int = 3
    @State var bedrooms: [ShowingsData]?
    @State var bathrooms: [ShowingsData]?
    
    @State var currentIndex: String?
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Address")
                    Text("Date")
                }
                VStack(alignment: .leading) {
                    TextField("Address", text: $address)
                    Text(Date().formatted(date: .abbreviated, time: .shortened))
                }
            }
            .padding()
            ScrollView {
                if let showings = showingsData, !showings.isEmpty {
                    
                    ForEach(showingsData ?? []) { data in
                        CategoryCell(text: data.type)
                            .onTapGesture {
                                path.append(data)
                            }
                    }
                    
                    ForEach(Array((bedrooms ?? []).enumerated()), id: \.element.id) { index, data in
                        CategoryCell(text: "Bedroom \(index + 1)",
                                     icon: "bed.double.fill",
                                     iconSize: CGSize(width: 40, height: 28))
                        .onTapGesture {
                            self.currentIndex = "\(index + 1)"
                            path.append(data)
                        }
                    }
                    
                    ForEach(Array((bathrooms ?? []).enumerated()), id: \.element.id) { index, data in
                        CategoryCell(text: "Bathroom \(index + 1)",
                                     icon: "bathtub.fill",
                                     iconSize: CGSize(width: 40, height: 28))
                        .onTapGesture {
                            self.currentIndex = "\(index + 1)"
                            path.append(data)
                        }
                    }
                    
                    CategoryCell(text: "Other Notes",
                                 icon: "note.text",
                                 iconSize: CGSize(width: 38, height: 38))
                    .onTapGesture {
                        otherNotesView = true
                    }
                }
            }
        }
        .toolbar {
            Button {
                if address.isEmpty {
                    self.showAlert = true
                } else {
                    navigate = true
                }
            } label: {
                Text("Preview")
            }
        }
        .onAppear {
            if firstLoad {
                firstLoad = false
                showDynamicSheet = true
                showings = Utility.fetchJson("showingdata")
                showingsData = showings?.data
                Constants.pdfData = PDFDataModel.prepareInitalData()
            }
        }
        .sheet(isPresented: $showDynamicSheet, onDismiss: {
            PDFDataModel.prepareBedRoomData(numberOfRooms: numerOfBedrooms)
            PDFDataModel.prepareBathRoomData(numberOfRooms: numerOfBathrooms)
        }) {
            DynamicShowingsInput(bedRooms: $numerOfBedrooms,
                                 bathRooms: $numerOfBathrooms,
                                 bedrooms: $bedrooms,
                                 bathrooms: $bathrooms)
            .presentationDetents([.height(100)])
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Please enter address to preview"), dismissButton: .default(Text("OK")))
        }
        .navigationDestination(isPresented: $navigate) {
            ShowingsPreview(address: $address)
        }
        .navigationDestination(isPresented: $otherNotesView) {
            VStack {
                NotesView(title: "", notes: otherNotes , height: 300) { otherNotes in
                    Constants.otherNotes = otherNotes
                    self.otherNotes = otherNotes
                }
                Spacer()
                    .navigationTitle("Other Notes")
            }
            .padding([.top, .horizontal])
        }
        .navigationDestination(for: ShowingsData.self) { data in
            Form {
                if data.type.lowercased().contains("bedroom") {
                    
                    let dataBinding = Binding<ShowingsData?>(
                        get: {
                            bedrooms?.first(where: { $0.id == data.id })
                        },
                        set: { newValue in
                            if let newValue = newValue,
                               let index = bedrooms?.firstIndex(where: { $0.id == newValue.id }) {
                                bedrooms?[index] = newValue
                            }
                        })
                    
                    SmartSection(data: dataBinding, index: self.currentIndex)
                    
                } else if data.type.lowercased().contains("bathroom") {
                    let dataBinding = Binding<ShowingsData?>(
                        get: {
                            bathrooms?.first(where: { $0.id == data.id })
                        },
                        set: { newValue in
                            if let newValue = newValue,
                               let index = bathrooms?.firstIndex(where: { $0.id == newValue.id }) {
                                bathrooms?[index] = newValue
                            }
                        })
                    
                    SmartSection(data: dataBinding, index: self.currentIndex)
                    
                } else {
                    let dataBinding = Binding<ShowingsData?>(
                        get: {
                            showingsData?.first(where: { $0.id == data.id })
                        },
                        set: { newValue in
                            if let newValue = newValue,
                               let index = showingsData?.firstIndex(where: { $0.id == newValue.id }) {
                                showingsData?[index] = newValue
                            }
                        })
                    SmartSection(data: dataBinding)
                }
            }
        }
    }
}


struct CategoryCell: View {
    var text: String
    var icon: String? = nil
    var iconSize: CGSize? = nil

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.theme)
            .frame(height: 90)
            .overlay {
                HStack(spacing: 5) {
                    Image(systemName: {
                        switch text {
                        case _ where text.starts(with: "Living Room"): return "sofa.fill"
                        case _ where text.starts(with: "Kitchen"): return "fork.knife"
                        case _ where text.starts(with: "Bathroom"): return "bathtub.fill" // Matches "Bathroom 1", "Bathroom 2", etc.
                        case _ where text.starts(with: "Bedroom"): return "bed.double.fill" // Matches "Bedroom 1", "Bedroom 2", etc.
                        case _ where text.starts(with: "Dining Room"): return "table.furniture.fill"
                        case _ where text.starts(with: "Entryway"): return "door.left.hand.open"
                        case _ where text.starts(with: "Exterior"): return "tree.fill"
                        case _ where text.starts(with: "Systems"): return "powerplug.portrait.fill"
                        case _ where text.starts(with: "Other Notes"): return "pencil.and.scribble"
                        default: return "cube.transparent"
                        }
                    }())
                    .resizable()
                    .scaledToFit() // Maintain natural proportions
                    .frame(maxWidth: iconSize?.width ?? 40, maxHeight: iconSize?.height ?? 40) // Optional maximum size
                    .foregroundStyle(Color(.foreground))
                    .padding(.trailing)

                    SSText(text: text)
                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
    }
}
