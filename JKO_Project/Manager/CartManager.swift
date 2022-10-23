import Foundation

class CartManager {
    static let shared = CartManager()
    private var currentCommodities = [CommodityInCart]()

    private init() {
        currentCommodities = Array(RealmManager.shared.fetch(CommodityInCart.self))
        currentCommodities.sort(by: { $0.createAt > $1.createAt })
    }
    
    func getCurrentCommodityAt(_ index: Int) -> CommodityInCart? {
        if currentCommodities.isEmpty || index >= currentCommodities.count {
            return nil
        }
        return currentCommodities[index]
    }
    
    func getCurrentCommodities() -> [CommodityInCart] {
        return currentCommodities
    }
    
    func add(_ commodities: [CommodityListCellViewModel]) {
        for commodity in commodities {
            let commodityInCart = CommodityInCart()
            commodityInCart.item = commodity
            commodityInCart.createAt = Int(Date().timeIntervalSince1970)
            RealmManager.shared.save(commodityInCart)
            currentCommodities.append(commodityInCart)
        }
        currentCommodities.sort(by: { $0.createAt > $1.createAt })
    }
    
    func deleteAt(_ index: Int) {
        if currentCommodities.isEmpty || index >= currentCommodities.count {
            return
        }
        let commodity = currentCommodities[index]
        RealmManager.shared.delete(commodity)
        currentCommodities.remove(at: index)
    }
}
