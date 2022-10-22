import UIKit
import LBTATools

class HistoryVC: UIViewController {
    private lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .insetGrouped)
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
        title = "歷史訂單"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.fillSuperviewSafeAreaLayoutGuide()
    }
}

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return RealmManager.shared.fetch(Order.self).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let orders = RealmManager.shared.fetch(Order.self)
        let order = orders[section]
        return order.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommodityListCell.cellId, for: indexPath) as! CommodityListCell
        cell.selectionStyle = .none
        let orders = RealmManager.shared.fetch(Order.self)
        let order = orders[indexPath.section]
        let item = order.items[indexPath.item]
        cell.commodity = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let orders = RealmManager.shared.fetch(Order.self)
        let order = orders[section]
        let timeIntervalSince1970 = order.createAt
        let timeInterval = TimeInterval(timeIntervalSince1970)
        titleLabel.text = timeInterval.toString(format: "yyyy/MM/dd HH:mm") + "\n$\(order.totalPrice)"
        header.addSubview(titleLabel)
        titleLabel.centerInSuperview()
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

