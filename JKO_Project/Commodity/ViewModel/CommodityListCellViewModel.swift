import Foundation
import UIKit
import RealmSwift

class CommodityListCellViewModel: Object {
    @Persisted var commodityImageData: Data
    @Persisted var commodityName: String
    @Persisted var commodityDescription: String
    @Persisted var commodityPrice: Int
    @Persisted var commodityPriceString: String
    @Persisted var commodityCreateDateString: String
    
    convenience init(commodity: GeneralCommidity) {
        self.init()
        let image = UIImage(named: commodity.imageName) ?? UIImage(named: "question")!
        let imageData = image.pngData() ?? Data()
        self.commodityImageData = imageData
        self.commodityName = commodity.name
        self.commodityDescription = commodity.descript
        self.commodityPrice = commodity.price
        self.commodityPriceString = "$\(commodity.price)"

        let timeIntervalSince1970 = commodity.createAt
        let timeInterval = TimeInterval(timeIntervalSince1970)
        self.commodityCreateDateString = timeInterval.toString(format: "yyyy/MM/dd")
    }
}
