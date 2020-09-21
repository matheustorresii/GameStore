import Foundation

struct Game: Codable, Hashable {
    let image: String
    let name: String
    let subtitle: String
    let price: Int
    let plot: String
    let platform: String
}
