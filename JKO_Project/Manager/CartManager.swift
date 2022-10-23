import Foundation

class CartManager {
    static let shared = CartManager()
    private var currentCommodities = [CommodityInCart]()
    private var checkStatus = [Bool]()
    
    private init() {
        currentCommodities = Array(RealmManager.shared.fetch(CommodityInCart.self))
        currentCommodities.sort(by: { $0.createAt > $1.createAt })
        checkStatus = Array(repeating: false, count: currentCommodities.count)
    }
    
    // MARK: - Commodity Operation
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
            checkStatus.insert(false, at: 0)
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
        deleteCheckStatusAt(index)
    }
    
    // MARK: - Check Status Operation
    func noCommoditiesWasChecked() -> Bool {
        if checkStatus.contains(true) == false {
            return true
        }
        return false
    }
    
    func getCommoditiesWasChecked() -> [CommodityInCart] {
        var array = [CommodityInCart]()
        for i in 0..<checkStatus.count {
            let isChecked = checkStatus[i]
            if isChecked {
                if let commodity = CartManager.shared.getCurrentCommodityAt(i) {
                    array.append(commodity)
                }
            }
        }
        return array
    }
    
    func getCheckStatusAt(_ index: Int) -> Bool? {
        if checkStatus.isEmpty || index >= checkStatus.count {
            return nil
        }
        return checkStatus[index]
    }
    
    func toggleCheckStatusAt(_ index: Int) {
        if checkStatus.isEmpty || index >= checkStatus.count {
            return
        }
        checkStatus[index].toggle()
    }
    
    func deleteCheckStatusAt(_ index: Int) {
        if checkStatus.isEmpty || index >= checkStatus.count {
            return
        }
        checkStatus.remove(at: index)
    }
}
