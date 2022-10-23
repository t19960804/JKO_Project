import Foundation
import Combine

class CommodityListViewModel: ObservableObject {
    @Published var items = [CommodityListCellViewModel]()

    func fetchData() {
        guard let url = Bundle.main.url(forResource: "TestData", withExtension: "json") else {
            print("Error - Can't get json")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            do {
                var collection = try JSONDecoder().decode(CommoditiesCollection.self, from: data)
                collection.items.sort(by: { $0.createAt > $1.createAt })
                self.items = collection.items.map { CommodityListCellViewModel(commodity: $0) }
            } catch {
                print("Error - Decode Failed:\(error)")
            }
        } catch {
            print("Error - Get Data Failed:\(error)")
        }
    }
}
