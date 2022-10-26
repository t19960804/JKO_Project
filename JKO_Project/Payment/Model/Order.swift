import Foundation
import RealmSwift

class Order: Object {
    @Persisted var items: List<CommodityListCellViewModel>
    @Persisted var createAt: Int
    @Persisted var totalPrice: Int
    
    convenience init(items: List<CommodityListCellViewModel>, totalPrice: Int) {
        self.init()
        self.items = items
        self.createAt = Int(Date().timeIntervalSince1970)
        self.totalPrice = totalPrice
    }
}
