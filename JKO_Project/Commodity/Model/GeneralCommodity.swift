import Foundation
import RealmSwift

class CommoditiesCollection: Codable {
    var items: [GeneralCommidity]
}

class GeneralCommidity: Object, Codable {
    @Persisted var name: String
    @Persisted var descript: String
    @Persisted var price: Int
    @Persisted var createAt: Int
    @Persisted var imageName: String
}
