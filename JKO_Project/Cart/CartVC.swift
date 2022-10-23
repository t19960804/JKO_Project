import UIKit
import LBTATools
import JGProgressHUD

class CartVC: UIViewController {
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(CommodityListCell.self, forCellReuseIdentifier: CommodityListCell.cellId)
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    private let hud: JGProgressHUD = {
        let hud = JGProgressHUD()
        let view = JGProgressHUDErrorIndicatorView()
        hud.indicatorView = view
        hud.textLabel.text = "請勾選一項商品"
        return hud
    }()
    
    private var checkStatus = Array(repeating: false, count: CartManager.shared.getCurrentCommodities().count)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupUI()
    }
    
    private func setupNavBar() {
        title = "購物車"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let settle = UIBarButtonItem(title: "結算", style: .plain, target: self, action: #selector(settleTapped))
        navigationItem.rightBarButtonItems = [settle]
    }
    
    @objc private func settleTapped() {
        var itemsChecked = [GeneralCommidity]()
        for i in 0..<checkStatus.count {
            let isChecked = checkStatus[i]
            if isChecked {
                if let commodity = CartManager.shared.getCurrentCommodityAt(i),
                   let item = commodity.item {
                    itemsChecked.append(item)
                }
            }
        }
        if itemsChecked.isEmpty {
            hud.show(in: self.view, animated: true)
            hud.dismiss(afterDelay: 1)
            return
        }
        let vc = PaymentVC(items: itemsChecked)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.fillSuperviewSafeAreaLayoutGuide()
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.getCurrentCommodities().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommodityListCell.cellId, for: indexPath) as! CommodityListCell
        if let item = CartManager.shared.getCurrentCommodityAt(indexPath.item)?.item {
            let vm = CommodityListCellViewModel(commodity: item)
            cell.vm = vm
        }
        
        let isChecked = checkStatus[indexPath.item]
        cell.accessoryType = isChecked ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommodityListCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let isChecked = checkStatus[indexPath.item]
        checkStatus[indexPath.item] = !isChecked
        cell?.accessoryType = checkStatus[indexPath.item] ? .checkmark : .none
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (_, _, _) in
            CartManager.shared.deleteAt(indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}
