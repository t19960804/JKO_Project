import Foundation

struct CommoditiesCollection: Codable {
    var items: [GeneralCommidity]
}

struct GeneralCommidity: Codable {
    var name: String
    var descript: String
    var price: Int
    var createAt: Int
    var imageName: String
}
