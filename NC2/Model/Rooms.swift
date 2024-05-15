import SwiftUI

struct Rooms: Identifiable {
    let id = UUID()
    let name: String
    var isSelected: Bool = false
}

