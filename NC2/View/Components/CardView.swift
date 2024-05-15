import SwiftUI

struct CardView: View {
    var assetImage: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 20.3)
            Image(assetImage)
                .resizable()
                .scaledToFit()
                .padding(10)
        }.frame(maxWidth: 526, maxHeight: 302.38)
           
    }
}

