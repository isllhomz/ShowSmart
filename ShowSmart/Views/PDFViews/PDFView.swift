import SwiftUI

struct PDFView: View {
    @Binding var address: String
    var body: some View {
        Section {
            HStack {
                Image(.logo)
                    .resizable()
                    .frame(width: 120, height: 100)
                
                VStack {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color(hex: "#2F425A"))
                        .frame(height: 40)
                        .overlay {
                            Text("Showing Summary")
                                .font(.custom("Raleway-Bold", size: 16))
                                .foregroundStyle(Color.white)
                        }
                    SSTextNormal(text: address)
                    SSTextNormal(text: Date().formatted(date: .abbreviated, time: .shortened))
                }
            }
            .padding()
            
            ForEach(Constants.pdfData) { data in
                ShowingPDFSection(title: data.title, items: data.items)
            }
            
            HStack(alignment: .top, spacing: 12) {
                SSTextNormal(text: "Other \nNotes", fontSize: 16, weightType: 2)
                SSTextNormal(text: Constants.otherNotes, fontSize: 14)
            }
            .padding(.horizontal)
            
            Text("Thanks for letting us show your property. If you have any questions on this or any other property, please reach out!")
                .frame(width: self.screenBounds.width)
                .font(.custom("Raleway-Regular", size: 14))
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                PDFContactSection(name: "Adam Haight",
                                  desgination: "Broker | Manager",
                                  address: "Re/Max Crown(1989) Realty Inc.",
                                  phone: "705.562.4807")
                Spacer()
                PDFContactSection(name: "Pam Haight",
                                  desgination: "Realtor*",
                                  address: "Re/Max Crown(1989) Realty Inc.",
                                  phone: "705.562.0169")
            }
            .padding()
            
            VStack(alignment: .leading) {
                SSTextNormal(text: "Disclaimer", fontSize: 20, weightType: 2)
                SSTextNormal(text: "The information provided in this checklist is based on our observations during\n the property showing and is intended for general reference only. While we've \n made every effort to capture accurate details, we recommend consulting with\n relevant professionals (e.g., home inspectors, contractors) for a thorough\n assessment. This checklist should not be considered a substitute for a formal\n property inspection or professional advice. We encourage you to conduct\n your own due diligence before making any decisions.", fontSize: 14)
            }.padding()
            
        }
    }
}
