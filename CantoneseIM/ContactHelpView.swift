import SwiftUI
import MessageUI

struct ContactHelpView: View {
        private let mailComposeDelegate = MailComposeDelegate()
        var body: some View {
                ScrollView(.vertical, showsIndicators: false) {
                        
                        
                        // MARK: - Websites
                        
                        VStack {
                                LinkButton(url: URL(string: "https://yuetyam.github.io/canim")!,
                                           content: MessageView(icon: "link.circle",
                                                                text: Text("Website"),
                                                                symbol: Image(systemName: "safari")))
                                
                                DivideLineView()
                                
                                LinkButton(url: URL(string: "https://yuetyam.github.io/canim/faq")!,
                                           content: MessageView(icon: "questionmark.circle",
                                                                text: Text("FAQ"),
                                                                symbol: Image(systemName: "safari")))
                        }
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                        .padding()
                        
                        
                        // MARK: - GitHub
                        
                        LinkButton(url: URL(string: "https://github.com/yuetyam/canim/issues")!,
                                   content: MessageView(icon: "link.circle",
                                                        text: Text("GitHub Issues page"),
                                                        symbol: Image(systemName: "safari")))
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding()
                        
                        
                        // MARK: - Twitter & Telegram
                        
                        VStack {
                                Button(action: {
                                        let telegramUrl: URL = URL(string: "https://t.me/can_im")!
                                        UIApplication.shared.open(telegramUrl, options: [:], completionHandler: nil)
                                }) {
                                        MessageView(icon: "paperplane",
                                                    text: Text("Telegram Group"),
                                                    symbol: Image(systemName: "arrow.right.square"))
                                }
                                DivideLineView()
                                Button(action: {
                                        let twitterUrl: URL = URL(string: "https://twitter.com/_cantonese")!
                                        UIApplication.shared.open(twitterUrl, options: [:], completionHandler: nil)
                                }) {
                                        MessageView(icon: "at",
                                                    text: Text("Follow us on Twitter"),
                                                    symbol: Image(systemName: "arrow.right.square"))
                                }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                        .padding()
                        
                        
                        // MARK: - Email Feedback
                        
                        MailFeedBackButton(mailComposeDelegate: mailComposeDelegate)
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding()
                                .padding(.bottom, 80)
                }
                .foregroundColor(.primary)
                .navigationBarTitle(Text("Contact & Help"), displayMode: .inline)
        }
}

struct ContactHelpView_Previews: PreviewProvider {
        static var previews: some View {
                ContactHelpView()
        }
}

private struct MailFeedBackButton: View {
        
        @State private var isPresented: Bool = false
        @State private var isMailOnPhoneUnavailable: Bool = false
        @State private var isMailOnPadUnavailable: Bool = false
        
        let mailComposeDelegate: MailComposeDelegate
        
        var body: some View {
                Button(action: {
                        if MFMailComposeViewController.canSendMail() {
                                self.isPresented.toggle()
                        } else if UIDevice.current.userInterfaceIdiom == .phone {
                                self.isMailOnPhoneUnavailable.toggle()
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        } else {
                                self.isMailOnPadUnavailable.toggle()
                        }
                }) {
                        MessageView(icon: "envelope",
                                    text: Text("Email Feedback"),
                                    symbol: Image(systemName: "square.and.pencil"))
                }
                .sheet(isPresented: $isPresented) { ComposeMailView(mailComposeDelegate: self.mailComposeDelegate) }
                .actionSheet(isPresented: $isMailOnPhoneUnavailable) {
                        ActionSheet(title: Text("Unable to compose mail"),
                                    message: Text("Mail Unavailable"),
                                    buttons: [.cancel(Text("OK"))])
                }
                .alert(isPresented: $isMailOnPadUnavailable) {
                        Alert(title: Text("Unable to compose mail"),
                              message: Text("Mail Unavailable"),
                              dismissButton: .cancel(Text("OK"))
                        )
                }
        }
}
private struct ComposeMailView: UIViewControllerRepresentable {
        typealias UIViewControllerType = MFMailComposeViewController
        let mailComposeDelegate: MailComposeDelegate
        
        func makeUIViewController(context: Context) -> MFMailComposeViewController {
                let mailCompose = MFMailComposeViewController()
                mailCompose.title = "User Feedback"
                mailCompose.setSubject("User Feedback")
                mailCompose.setToRecipients(["bing@ososo.io"])
                mailCompose.setMessageBody("Enter your feedback here", isHTML: true)
                mailCompose.mailComposeDelegate = mailComposeDelegate
                return mailCompose
        }
        func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) { }
}
private final class MailComposeDelegate: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
                controller.dismiss(animated: true, completion: nil)
        }
}
