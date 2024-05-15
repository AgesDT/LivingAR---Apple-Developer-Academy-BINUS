
import SwiftUI

struct CardSlide: View {
    @Binding var cardIndex: Int
    private let img: [String] = ["previewPNG_3", "previewPNG_1", "previewPNG_2"]
    
    var body: some View {
        VStack{
            ZStack{
                
                ForEach(0..<img.count, id: \.self){index in
                    CardView(assetImage: img[index])
                        .blur(radius: cardIndex == index ? 0.0 : 6.0)
                        .offset(y:CGFloat(index - cardIndex)*400)
                        .onTapGesture {
                            withAnimation{
                                cardIndex = index
                            }
                        }
                }
                
            }
        }
    }
}


