import Foundation
import UIKit

struct CommodityListCellViewModel {
    let commodityImage: UIImage
    let commodityName: String
    let commodityDescription: String
    let commodityPrice: String
    let commodityCreateDate: String
    
    init(commodity: GeneralCommidity) {
        self.commodityImage = UIImage(named: commodity.imageName) ?? UIImage(named: "question")!
        self.commodityName = commodity.name
        self.commodityDescription = commodity.descript
        self.commodityPrice = "$\(commodity.price)"

        let timeIntervalSince1970 = commodity.createAt
        let timeInterval = TimeInterval(timeIntervalSince1970)
        self.commodityCreateDate = timeInterval.toString(format: "yyyy/MM/dd")
    }
}
