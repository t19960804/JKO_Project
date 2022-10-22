import Foundation

class CartManager {
    static let shared = CartManager()
    var currentCommodities = [GeneralCommidity]()
    
    private init() {
        
    }
    
    func add(_ commodities: [GeneralCommidity]) {
        currentCommodities += commodities
    }
}
