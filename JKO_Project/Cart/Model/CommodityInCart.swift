import Foundation
import RealmSwift

class CommodityInCart: Object {
    @Persisted var item: CommodityListCellViewModel?
    @Persisted var createAt: Int
}
