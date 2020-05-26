import SwiftUI

struct CardView: View {
        
        let headline: Text
        let content: Text
        
        var body: some View {
                VStack {
                        HStack {
                                headline.lineLimit(1).font(.system(size: 22, weight: .semibold, design: .default))
                                Spacer()
                        }
                        .padding(.bottom, 16)
                        HStack {
                                content
                                Spacer()
                        }
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.secondary))
        }
        
        init(headline: Text, content: Text) {
                self.headline = headline
                self.content = content
        }
}

struct CardView_Previews: PreviewProvider {
        static var previews: some View {
                CardView(headline: Text("Headline"), content: Text("Make America Great Again"))
        }
}
