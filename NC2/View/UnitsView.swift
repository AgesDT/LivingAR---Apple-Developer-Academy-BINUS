import SwiftUI
import SceneKit

struct UnitsView: View {
    @State private var searchUnit = ""
    @Binding var cardIndex: Int
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    // Two Columns Layout
                    HStack(spacing: 0) {
                        HouseUnits()
                            .frame(width: geometry.size.width / 2)

                        Divider()

                        HousePreviews(cardIndex: $cardIndex)
                            .frame(width: geometry.size.width / 2)
                    }
                }
                .navigationTitle("Units Design")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}

struct HousePreviews: View {
    let housePreviews = [
        HousePreview(name: "House PREVIEW 1")
    ]
    @Binding var cardIndex: Int // Add State variable

    var body: some View {
        VStack {
            Spacer()
            SceneView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Spacer()
            
            NavigationLink(destination: DesignsView(cardIndex: cardIndex)) { // Pass Binding here
                Text("More Details")
            }
            .buttonStyle(.borderedProminent)
            .padding(4)
            Spacer().frame(height: 20)
        }
        .padding()
    }
}

struct HouseUnits: View {
    @State private var houseUnits = [
        HouseUnit(name: "House Unit 1"),
        HouseUnit(name: "House Unit 2"),
        HouseUnit(name: "House Unit 3")
    ]

    var body: some View {
        List {
            ForEach($houseUnits.indices, id: \.self) { index in
                Button(action: {
                    // Toggle selection only on the tapped unit
                    for i in houseUnits.indices {
                        houseUnits[i].isSelected = (i == index)
                    }
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(houseUnits[index].name)
                                .foregroundColor(.blue)
                            
                            Text("3 x 6 meters")
                                .foregroundColor(.gray)
                        }
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }.fontWeight(houseUnits[index].isSelected ? .bold : .regular)
                }
            }
        }.listStyle(.plain)
    }
}


