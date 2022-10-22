import Foundation
import Combine

class CommodityListViewModel: ObservableObject {
    @Published var items = [GeneralCommidity]()

    func fetchData() {
        guard let url = Bundle.main.url(forResource: "TestData", withExtension: "json") else {
            print("Error - Can't get json")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            do {
                let collection = try JSONDecoder().decode(CommoditiesCollection.self, from: data)
                collection.items.sort(by: { $0.createAt > $1.createAt })
                self.items = collection.items
            } catch {
                print("Error - Decode Failed:\(error)")
            }
        } catch {
            print("Error - Get Data Failed:\(error)")
        }
    }
}
