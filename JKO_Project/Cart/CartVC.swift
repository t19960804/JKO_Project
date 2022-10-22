import UIKit
import LBTATools

class CartVC: UIViewController {
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(CommodityListCell.self, forCellReuseIdentifier: CommodityListCell.cellId)
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupUI()
    }
    
    private func setupNavBar() {
        let settle = UIBarButtonItem(title: "結算", style: .plain, target: self, action: #selector(settleTapped))
        navigationItem.rightBarButtonItems = [settle]
    }
    
    @objc private func settleTapped() {
        print("結算")
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.fillSuperviewSafeAreaLayoutGuide()
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.currentCommodities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommodityListCell.cellId, for: indexPath) as! CommodityListCell
        let items = CartManager.shared.currentCommodities
        cell.commodity = items[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
