import Foundation

struct CommoditiesCollection: Codable {
    let items: [GeneralCommidity]
}
struct GeneralCommidity: Codable {
    let name: String
    let description: String
    let price: Int
    let createAt: Int
    let imageName: String
}
