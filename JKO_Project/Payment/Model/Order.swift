import Foundation
import RealmSwift

class Order: Object {
    @Persisted var items: List<CommodityInCart>
    @Persisted var createAt: Int
    @Persisted var totalPrice: Int
}
