import Foundation
import RealmSwift

class Order: Object {
    @Persisted var items: List<GeneralCommidity>
    @Persisted var createAt: Int
    @Persisted var totalPrice: Int
}
