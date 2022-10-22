import Foundation
import RealmSwift

class CommodityInCart: Object {
    @Persisted var item: GeneralCommidity?
    @Persisted var createAt: Int
}
