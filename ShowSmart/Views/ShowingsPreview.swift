import SwiftUI
import Combine

struct ShowingsPreview: View {
    @State private var showPDFView = false
    @State private var showingAlert = false
    @Binding var address: String
    @State private var alertMessage = ""
    @StateObject var proprtyVM = PropertyVM()
    @StateObject var emailVC = EmailController()
    
    var body: some View {
        
        List {
            if showPDFView {
                PDFView(address: $address)
                    .onAppear {
                        if emailVC.status {
                            alertMessage = "Email send successfully"
                        } else {
                            alertMessage = "Unable to send email, please check you client email"
                        }
                    }
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
        .listRowSeparator(.hidden)
        .toolbar {
            Button("Send to client") {
                let renderer = ImageRenderer(content: PDFView(address: $address))
                renderer.render { size, renderInContext in
                    
                    let pageWidth: CGFloat = 595.2
                    let pageHeight: CGFloat = 841.8
                    
                    let scaleFactor = pageWidth / size.width
                    let scaledHeight = size.height * scaleFactor
                    
                    var box = CGRect(origin: .zero,
                                     size: .init(width: pageWidth, height: pageHeight)
                    )
                    
                    let documentDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
                    let fileUrl = documentDirectory.appendingPathComponent("showing.pdf")
                    print(fileUrl)
                    guard let context = CGContext(fileUrl as CFURL, mediaBox: &box, nil) else {
                        return
                    }
                    
                    let totalPages = Int(ceil(scaledHeight / pageHeight))
                    
                    for pageIndex in (0..<totalPages).reversed() {
                        let yOffset = CGFloat(pageIndex) * pageHeight / scaleFactor
                        context.beginPDFPage(nil)
                        context.saveGState()
                        context.translateBy(x: 0, y: (pageHeight - (yOffset * scaleFactor)))
                        renderInContext(context)
                        context.restoreGState()
                        
                        context.endPDFPage()
                    }
                    
                    context.closePDF()
                    
                    if let client =  Constants.selectedClient, let data = try? Data(contentsOf: fileUrl) {
                        if emailVC.sendEmail(pdfUrl: fileUrl, email: client.email, addrees: self.address) {
                            let property = PropertyModel(name: "", address: address, date: Date(), details: data, client: client)
                            proprtyVM.addProperty(property)
                        } else {
                            showingAlert = true
                        }
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .overlay {
            if !showPDFView {
                PDFLoaderView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            showPDFView = true
                        }
                    }
            }
        }
    }
}
