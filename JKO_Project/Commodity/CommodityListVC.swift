import UIKit
import LBTATools

class CommodityListVC: UIViewController {
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(CommodityListCell.self, forCellReuseIdentifier: CommodityListCell.cellId)
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    private var items = [GeneralCommidity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchData()
        setupNavBar()
        setupUI()
    }

    private func fetchData() {
        guard let url = Bundle.main.url(forResource: "TestData", withExtension: "json") else {
            print("Error - Can't get json")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            do {
                let collection = try JSONDecoder().decode(CommoditiesCollection.self, from: data)
                self.items = collection.items
                self.items.sort(by: { $0.createAt > $1.createAt })
            } catch {
                print("Error - Decode Failed:\(error)")
            }
        } catch {
            print("Error - Get Data Failed:\(error)")
        }
    }
    
    private func setupNavBar() {
        title = "商品列表"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let cart = UIBarButtonItem(title: "購物車", style: .plain, target: self, action: #selector(cartTapped))
        let history = UIBarButtonItem(title: "歷史訂單", style: .plain, target: self, action: #selector(historyTapped))
        navigationItem.rightBarButtonItems = [cart, history]
    }
    
    @objc private func cartTapped() {
        let vc = CartVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func historyTapped() {
        let vc = HistoryVC()
        navigationController?.pushViewController(vc, animated: true)
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
        cell.selectionStyle = .none
        cell.commodity = items[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommodityDetailVC(commodity: items[indexPath.item])
        navigationController?.pushViewController(vc, animated: true)
    }
}
