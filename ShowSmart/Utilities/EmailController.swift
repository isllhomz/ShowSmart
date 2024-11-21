import MessageUI
import Combine

final class EmailController: NSObject, MFMailComposeViewControllerDelegate, ObservableObject {
    
    @Published var status: Bool = false
    
    func sendEmail(pdfUrl: URL, email: String, addrees: String) -> Bool {
        guard MFMailComposeViewController.canSendMail() else {
            print("Cannot send mail")
            return false
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([email])
        composer.setSubject("Your showing report: \(addrees)")
        composer.setMessageBody("Please find the attached PDF document.", isHTML: false)
        
        guard let pdfData = try? Data(contentsOf: pdfUrl) else {
            return false
        }
        composer.addAttachmentData(pdfData, mimeType: "application/pdf", fileName: "showings.pdf")
        
        guard let rootVC = getRootController() else {
            return false
        }
        
        rootVC.present(composer, animated: true)
        return true
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        getRootController()?.dismiss(animated: true) { [self] in
            switch result {
            case .cancelled, .saved, .failed:
                self.status = false
            case .sent:
                self.status = true
            @unknown default:
                break
            }
        }
    }
    
    func getRootController() -> UIViewController? {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return nil
        }
        
        return root
    }
}
