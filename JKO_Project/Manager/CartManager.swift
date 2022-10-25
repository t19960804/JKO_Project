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
    
    func addCommodities(_ commodities: [CommodityListCellViewModel]) {
        for commodity in commodities {
            let commodityInCart = CommodityInCart(item: commodity)
            RealmManager.shared.save(commodityInCart)
            currentCommodities.append(commodityInCart)
        }
        currentCommodities.sort(by: { $0.createAt > $1.createAt })
    }
    
    func deleteCommodityAt(_ index: Int) {
        if currentCommodities.isEmpty || index >= currentCommodities.count {
            return
        }
        let commodity = currentCommodities[index]
        RealmManager.shared.delete(commodity)
        currentCommodities.remove(at: index)
    }
    
    func noCommoditiesWasChecked() -> Bool {
        for commodity in currentCommodities {
            if commodity.isChecked {
                return false
            }
        }
        return true
    }
    
    func getCommoditiesWasChecked() -> [CommodityInCart] {
        return currentCommodities.filter { $0.isChecked }
    }
    
    func getCheckStatusAt(_ index: Int) -> Bool? {
        if currentCommodities.isEmpty || index >= currentCommodities.count {
            return nil
        }
        return currentCommodities[index].isChecked
    }
    
    func toggleCheckStatusAt(_ index: Int) {
        if currentCommodities.isEmpty || index >= currentCommodities.count {
            return
        }
        currentCommodities[index].isChecked.toggle()
    }
}
