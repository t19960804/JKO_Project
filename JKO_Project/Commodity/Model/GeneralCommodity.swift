import Foundation

protocol JKO_Commidity {
    var name: String { get }
    var descript: String { get }
    var price: Int { get }
    var createAt: Int { get }
    var imageName: String { get }
}

struct CommoditiesCollection: Codable {
    var items: [GeneralCommidity]
}

struct GeneralCommidity: Codable, JKO_Commidity {
    var name: String
    var descript: String
    var price: Int
    var createAt: Int
    var imageName: String
}
