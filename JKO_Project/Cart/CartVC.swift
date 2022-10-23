import UIKit
import LBTATools
import JGProgressHUD
import RealmSwift

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
        if CartManager.shared.noCommoditiesWasChecked() {
            hud.show(in: self.view, animated: true)
            hud.dismiss(afterDelay: 1)
            return
        }
        
        var vms = [CommodityListCellViewModel]()
        let commoditiesWasChecked = CartManager.shared.getCommoditiesWasChecked()
        commoditiesWasChecked.forEach({
            if let item = $0.item {
                vms.append(item)
            }
        })
        
        let itemList = List<CommodityListCellViewModel>()
        itemList.append(objectsIn: vms)
        let order = Order(items: itemList)
        let vc = PaymentVC(order: order)
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
        if let item = CartManager.shared.getCurrentCommodityAt(indexPath.item)?.item,
           let isChecked = CartManager.shared.getCheckStatusAt(indexPath.item) {
            cell.vm = item
            cell.accessoryType = isChecked ? .checkmark : .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommodityListCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        CartManager.shared.toggleCheckStatusAt(indexPath.item)
        if let checkStatus = CartManager.shared.getCheckStatusAt(indexPath.item) {
            cell?.accessoryType = checkStatus ? .checkmark : .none
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (_, _, _) in
            CartManager.shared.deleteCommodityAt(indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}
