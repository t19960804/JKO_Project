import Foundation

class CartManager {
    static let shared = CartManager()
    private var currentCommodities = [GeneralCommidity]()

    private init() {
        
    }
    
    func getCurrentCommodityAt(_ index: Int) -> GeneralCommidity? {
        if currentCommodities.isEmpty || index >= currentCommodities.count {
            return nil
        }
        return currentCommodities[index]
    }
    
    func getNumberOfCurrentCommodities() -> Int {
        currentCommodities.count
    }
    
    func add(_ commodities: [GeneralCommidity]) {
        currentCommodities += commodities
    }
}
