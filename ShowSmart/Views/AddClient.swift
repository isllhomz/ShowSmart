import SwiftUI
import ContactsUI

struct AddClient: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var alertMsg = ""
    @State private var showAlert = false
    @State private var pickedNumber: (String?, String?)
    @StateObject private var coordinator = Coordinator()
    @Binding var path: NavigationPath
    var clientsVM = ClientsVM()
    var store = CNContactStore()
    var isValid: Bool {
        get { return !name.isEmpty && !email.isEmpty && !phone.isEmpty }
    }

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Add client details")) {
                    HStack(spacing: 20) {
                        Text("Name")
                        TextField("Name", text: $name)
                    }
                    HStack(spacing: 20) {
                        Text("Email")
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    HStack(spacing: 20) {
                        Text("Phone")
                        TextField("Phone", text: $phone)
                            .keyboardType(.phonePad)
                    }
                    HStack(alignment: .center) {
                        Spacer()
                        Button {
                            store.requestAccess(for: .contacts) { (granted, error) in
                                if granted {
                                    DispatchQueue.main.async {
                                        openContactPicker()
                                    }
                                } else {
                                    alertMsg = "Contacts permission not grated, please go to setting and grant permission"
                                    showAlert = true
                                }
                            }
                            
                        } label: {
                            Text("Import from contacts")
                        }
                        Spacer()
                    }
                }
            }
            .toolbar {
                Button {
                    if !isValid {
                        alertMsg = "Fill all fields to continue"
                    } else {
                        clientsVM.addClient(ClientModel(name: name,
                                                        email: email,
                                                        phone: phone,
                                                        date: Date(),
                                                        properties: nil))
                        alertMsg = "Client Added successfully."
                    }
                    showAlert = true
                } label: {
                    Text("Add Client")
                }
            }
        }
        .alert(alertMsg, isPresented: $showAlert) {
            Button {
                if isValid { path.removeLast() }
            } label: {
                SSButton(title: "Ok")
            }
        }
        .onReceive(coordinator.$pickedNumber, perform: { (phone, name, email) in
            self.name = name ?? ""
            self.phone = phone ?? ""
            self.email = email ?? ""
        })
        .environmentObject(coordinator)
    }
    
    func openContactPicker() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = coordinator
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        contactPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        contactPicker.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
        contactPicker.predicateForSelectionOfProperty = NSPredicate(format: "key == 'phoneNumbers'")
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        window?.rootViewController?.present(contactPicker, animated: true, completion: nil)
    }
}

class Coordinator: NSObject, ObservableObject, CNContactPickerDelegate {
    @Published var pickedNumber: (String?,String?, String?)
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.pickedNumber = (nil,nil, nil)
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            handlePhoneNumber(phoneNumber,
                              contactName: "\(contact.givenName) \(contact.familyName)",
                              email: "\(contact.emailAddresses.first?.value ?? "")")
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        
        let contact = contactProperty.contact
        let email = "\(contact.emailAddresses.first?.value ?? "")"
        let fullName = "\(contact.givenName) \(contact.familyName)"
        
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            handlePhoneNumber(phoneNumber, contactName: fullName, email: email)
        }
    }
    
    private func handlePhoneNumber(_ phoneNumber: String, contactName: String, email: String?) {
        var phoneNumberWithoutSpace = phoneNumber.replacingOccurrences(of: " ", with: "")
        if phoneNumberWithoutSpace.hasPrefix("+") {
            phoneNumberWithoutSpace = String(phoneNumberWithoutSpace.dropFirst())
        }
        let sanitizedPhoneNumber = (phoneNumberWithoutSpace, contactName, email)
        
        DispatchQueue.main.async {
            self.pickedNumber = sanitizedPhoneNumber
        }
    }
}
