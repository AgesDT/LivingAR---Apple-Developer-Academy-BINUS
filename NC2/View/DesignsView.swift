import SwiftUI

struct DesignsView: View {
    @State private var searchUnit = ""
    @State private var cardIndex: Int = 1

    init(cardIndex: Int) {
        self._cardIndex = State(initialValue: cardIndex)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    HStack(spacing: 0) {
                        col1(cardIndex: $cardIndex)
                            .frame(width: geometry.size.width / 2)
                        Divider()
                        col2(cardIndex: $cardIndex)
                            .frame(width: geometry.size.width / 2)
                    }
                }
                .navigationTitle("Design View")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct col2: View {
    @State private var rooms = [
        Rooms(name: "Master Bedroom"),
        Rooms(name: "Second Bedroom"),
        Rooms(name: "Living Room"),
        Rooms(name: "Kitchen")
    ]
    @Binding var cardIndex: Int

    var body: some View {
        VStack {
            if self.cardIndex == 2 {
                SceneView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
                NavigationLink(destination: ARExterior()) {
                    HStack {
                        Image(systemName: "camera.viewfinder")
                        Text("View Model")
                    }.padding(4)
                }
                .buttonStyle(.borderedProminent)
            } else {
                List {
                    ForEach($rooms.indices, id: \.self) { index in
                        Button(action: {
                            for i in rooms.indices {
                                rooms[i].isSelected = (i == index)
                            }
                            
                        }) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(rooms[index].name)
                                        .foregroundColor(.blue)
                                    Text("2 x 3 meters")
                                        .foregroundColor(.gray)
                                }
                                .fontWeight(rooms[index].isSelected ? .bold : .regular)
                                .multilineTextAlignment(.leading)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                Spacer().frame(height: 350)
                NavigationLink(destination: ARInterior()) {
                    HStack {
                        Image(systemName: "camera.viewfinder")
                        Text("View Model")
                    }.padding(4)
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer().frame(height: 20)
        }
        .padding()
    }
}

struct col1: View {
    @Binding var cardIndex: Int

    var body: some View {
        CardSlide(cardIndex: $cardIndex)
    }
}

