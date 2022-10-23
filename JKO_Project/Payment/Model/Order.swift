import Foundation
import RealmSwift

class Order: Object {
    @Persisted var items: List<CommodityListCellViewModel>
    @Persisted var createAt: Int
    @Persisted var totalPrice: Int
    
    convenience init(items: List<CommodityListCellViewModel>) {
        self.init()
        self.items = items
        self.createAt = Int(Date().timeIntervalSince1970)
        self.totalPrice = getTotalPrice()
    }
    
    private func getTotalPrice() -> Int {
        var totalPrice = 0
        items.forEach {
            totalPrice += $0.commodityPrice
        }
        return totalPrice
    }
}
