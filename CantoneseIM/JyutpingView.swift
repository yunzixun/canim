import SwiftUI

struct JyutpingView: View {
        
        @State private var inputText: String = String()
        private var jyutpings: [String] { JyutpingProvider.search(for: inputText) }
        
        private let placeholdText: String = NSLocalizedString("Search the Jyutping of Cantonese word", comment: "")
        
        var body: some View {
                NavigationView {
                        ScrollView(.vertical, showsIndicators: false) {
                                Divider()
                                
                                 EnhancedTextField(placeholder: placeholdText, text: $inputText)
                                        .padding(8)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.secondary).opacity(0.5))
                                        .padding()
                                
                                if inputText.count > 0 {
                                        if jyutpings.count == 0 {
                                                HStack {
                                                        Text("No results.") + Text("\n") + Text("Common Cantonese words only.").font(.footnote)
                                                        Spacer()
                                                }
                                                .padding()
                                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                                .padding(.horizontal, 16)
                                        } else {
                                                VStack {
                                                        HStack {
                                                                Text(inputText).font(.headline)
                                                        }.padding()
                                                        DivideLineView()
                                                        ForEach(jyutpings) { (jyutping) in
                                                                HStack {
                                                                        Text(jyutping).font(.system(.body, design: .monospaced)).fixedSize(horizontal: false, vertical: true)
                                                                        Spacer()
                                                                }
                                                                .padding()
                                                                DivideLineView().opacity(jyutping == (self.jyutpings.last ?? "") ? 0 : 0.5)
                                                        }
                                                }
                                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                                .padding(.horizontal, 16)
                                        }
                                }
                                
                                HStack {
                                        Text("Search on other places (websites)").font(.headline)
                                        Spacer()
                                }
                                .padding(.horizontal, 24)
                                .padding(.top, 24)
                                
                                SearchWebsitesView()
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary.opacity(0.2)))
                                .padding(.horizontal, 8)
                                
                                HStack {
                                        Text("Jyutping resources").font(.headline)
                                        Spacer()
                                }
                                .padding(.horizontal, 24)
                                .padding(.top, 32)
                                
                                JyutpingWebsitesView()
                                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary.opacity(0.2)))
                                        .padding(.horizontal, 8)
                                        .padding(.bottom, 80)
                        }
                        .foregroundColor(.primary)
                        .navigationBarTitle(Text("Jyutping"))
                }
                .tabItem {
                        Image(systemName: "doc.text.magnifyingglass")
                        Text("Jyutping")
                }
                .tag(2)
                .navigationViewStyle(StackNavigationViewStyle())
        }
}

struct JyutpingView_Previews: PreviewProvider {
        static var previews: some View {
                JyutpingView()
        }
}

extension String: Identifiable {
        public var id: UUID {
                return UUID()
        }
}

struct SearchWebsitesView: View {
        var body: some View {
                VStack {
                        LinkButton(url: URL(string: "https://jyut.net")!,
                                   content: MessageView(icon: "link.circle",
                                                        text: Text("粵音資料集叢"),
                                                        symbol: Image(systemName: "safari")))
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding(.horizontal, 16)
                        
                        LinkButton(url: URL(string: "https://words.hk")!,
                                   content: MessageView(icon: "link.circle",
                                                        text: Text("粵典"),
                                                        symbol: Image(systemName: "safari")))
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding(.horizontal, 16)
                        
                        LinkButton(url: URL(string: "https://humanum.arts.cuhk.edu.hk/Lexis/lexi-can")!,
                                   content: MessageView(icon: "link.circle",
                                                        text: Text("粵語審音配詞字庫"),
                                                        symbol: Image(systemName: "safari")))
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding(.horizontal, 16)
                        
                        LinkButton(url: URL(string: "https://www.jyutdict.org")!,
                                   content: MessageView(icon: "link.circle",
                                                        text: Text("泛粵大典"),
                                                        symbol: Image(systemName: "safari")))
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding(.horizontal, 16)
                        
                        LinkButton(url: URL(string: "https://open-dict-data.github.io/ipa-lookup/yue")!,
                                   content: MessageView(icon: "link.circle",
                                                        text: Text("粵語國際音標查詢"),
                                                        symbol: Image(systemName: "safari")))
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding(.horizontal, 16)
                }
                .padding(.top, 16)
                .padding(.bottom, 16)
        }
}

struct JyutpingWebsitesView: View {
        var body: some View {
                VStack {
                        LinkButton(url: URL(string: "https://www.jyutping.org/")!,
                                   content: MessageView(icon: "link.circle",
                                                        text: Text("粵拼 jyutping.org"),
                                                        symbol: Image(systemName: "safari")))
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding(.horizontal, 16)
                        
                        LinkButton(url: URL(string: "https://www.lshk.org/jyutping")!,
                                   content: MessageView(icon: "link.circle",
                                                        text: Text("LSHK Jyutping 粵拼"),
                                                        symbol: Image(systemName: "safari")))
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding(.horizontal, 16)
                        
                        LinkButton(url: URL(string: "https://www.youtube.com/channel/UCcmAegX-cgcOOconZIwqynw")!,
                                   content: MessageView(icon: "link.circle",
                                                        text: Text("粵拼視頻教學 - YouTube"),
                                                        symbol: Image(systemName: "safari")))
                                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                                .padding(.horizontal, 16)
                        
                        LinkButton(url: URL(string: "http://jyutping.lt.cityu.edu.hk")!,
                           content: MessageView(icon: "link.circle",
                                                text: Text("粵語拼音資源站 - CityU"),
                                                symbol: Image(systemName: "safari")))
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                        .padding(.horizontal, 16)
                        
                        LinkButton(url: URL(string: "http://www.iso10646hk.net/jp")!,
                           content: MessageView(icon: "link.circle",
                                                text: Text("粵拼 - iso10646hk.net"),
                                                symbol: Image(systemName: "safari")))
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
                        .padding(.horizontal, 16)
                }
                .padding(.top, 16)
                .padding(.bottom, 16)
        }
}
