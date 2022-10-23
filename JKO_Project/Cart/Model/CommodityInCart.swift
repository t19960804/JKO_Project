import Foundation
import RealmSwift

class CommodityInCart: Object {
    @Persisted var item: CommodityListCellViewModel?
    @Persisted var createAt: Int
    
    convenience init(item: CommodityListCellViewModel) {
        self.init()
        self.item = item
        self.createAt = Int(Date().timeIntervalSince1970)
    }
}
