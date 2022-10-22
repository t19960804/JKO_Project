import UIKit
import LBTATools

class CommodityListVC: UIViewController {
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(CommodityListCell.self, forCellReuseIdentifier: CommodityListCell.cellId)
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    var items = [GeneralCommidity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "商品列表"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let url = Bundle.main.url(forResource: "TestData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                do {
                    let collection = try JSONDecoder().decode(CommoditiesCollection.self, from: data)
                    self.items = collection.items
                } catch {
                    print("Error - Decode Failed:\(error)")
                }
            } catch {
                print("Error - Get Data Failed:\(error)")
            }
        }
        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.fillSuperviewSafeAreaLayoutGuide()
    }
}

extension CommodityListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommodityListCell.cellId, for: indexPath) as! CommodityListCell
        cell.commodity = items[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("123")
    }
}
