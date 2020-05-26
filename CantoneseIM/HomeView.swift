import SwiftUI

struct HomeView: View {
        @State private var placeholdText: String = ""
        var body: some View {
                NavigationView {
                        ScrollView(.vertical, showsIndicators: false) {
                                Divider()
                                
                                TextField("Type here to test keyboards",
                                          text: $placeholdText).textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding()
                                
                                CardView(headline: Text("How to enable this Keyboard"),
                                         content: Text("•  Jump to ") + Text("Settings").fontWeight(.semibold) + Text("\n") +
                                                Text("•  Tap ") + Text("Keyboards").fontWeight(.semibold) + Text("\n") +
                                                Text("•  Turn on ") + Text("Canim").fontWeight(.semibold) + Text(" ") + Text("Keyboard"))
                                        .padding()
                                Button(action: {
                                        let url: URL = URL(string: UIApplication.openSettingsURLString)!
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }) {
                                        HStack{
                                                Spacer()
                                                Text("Open ") + Text("Settings").fontWeight(.semibold) + Text(" App")
                                                Spacer()
                                        }
                                }
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding(.horizontal, 16)
                                
                                CardView(headline: Text("How to add or edit keyboards"),
                                         content: Text("Go to ") +
                                                Text("Settings").fontWeight(.semibold) + Text(" App   →   ") +
                                                Text("General").fontWeight(.semibold) + Text("   →   ") +
                                                Text("Keyboard").fontWeight(.semibold) + Text("   →   ") +
                                                Text("Keyboards").fontWeight(.semibold) + Text(", then ") +
                                                Text("Add New Keyboards...").fontWeight(.semibold) + Text(" or ") +
                                                Text("Edit").fontWeight(.semibold) + Text("\n"))
                                        .padding()
                                        .padding(.top, 85)
                                        .padding(.bottom, 80)
                        }
                        .navigationBarTitle(Text("Home"))
                }
                .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                }
                .tag(0)
                .navigationViewStyle(StackNavigationViewStyle())
        }
}

struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
                HomeView()
        }
}
