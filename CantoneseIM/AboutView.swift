import SwiftUI
import StoreKit

struct AboutView: View {
        
        private let versionNumberText: String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "error"
        private let buildNumberText: String = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? "error"
        
        var body: some View {
                NavigationView {
                        ScrollView(.vertical) {
                                Divider()
                                
                                
                                // MARK: - Version
                                
                                MessageView(icon: "info.circle",
                                            text: Text("Version"),
                                            message: Text(versionNumberText + " (" + buildNumberText + ")"))
                                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                        .padding()
                                
                                
                                // MARK: - Source Code & Privacy
                                
                                VStack {
                                        LinkButton(url: URL(string: "https://github.com/yuetyam/canim")!,
                                                   content: MessageView(icon: "number.circle",
                                                                        text: Text("Source Code"),
                                                                        symbol: Image(systemName: "safari")))
                                        
                                        DivideLineView()
                                        NavigationLink(destination: AcknowledgementsView()) {
                                                MessageView(icon: "wand.and.stars",
                                                            text: Text("Acknowledgements"),
                                                            symbol: Image(systemName: "chevron.right"))
                                        }
                                        
                                        DivideLineView()
                                        LinkButton(url: URL(string: "https://yuetyam.github.io/canim/privacy/privacy-policy-ios")!,
                                                   content: MessageView(icon: "lock.circle",
                                                                        text: Text("Privacy Policy"),
                                                                        symbol: Image(systemName: "safari")))
                                }
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding()
                                
                                
                                // MARK: - Contact & Help
                                
                                NavigationLink(destination: ContactHelpView()) {
                                        MessageView(icon: "hand.raised",
                                                    text: Text("Contact & Help"),
                                                    symbol: Image(systemName: "chevron.right"))
                                }
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding()
                                
                                
                                // MARK: - Review & Share
                                
                                VStack {
                                        Button(action: { SKStoreReviewController.requestReview() }) {
                                                MessageView(icon: "heart", text: Text("Review this App"))
                                        }
                                        DivideLineView()
                                        ShareSheetView(content: MessageView(icon: "square.and.arrow.up", text: Text("Share this App")),
                                                       activityItems: [URL(string: "https://apps.apple.com/app/id1509367629")!])
                                }
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding()
                                .padding(.bottom, 80)
                        }
                        .foregroundColor(.primary)
                        .navigationBarTitle(Text("About"))
                }
                .tabItem {
                        Image(systemName: "info.circle")
                        Text("About")
                }
                .tag(3)
                .navigationViewStyle(StackNavigationViewStyle())
        }
}

struct AboutView_Previews: PreviewProvider {
        static var previews: some View {
                AboutView()
        }
}
