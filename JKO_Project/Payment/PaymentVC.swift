import UIKit
import LBTATools
import RealmSwift
import JGProgressHUD

class PaymentVC: UIViewController {
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(CommodityListCell.self, forCellReuseIdentifier: CommodityListCell.cellId)
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    private let hud: JGProgressHUD = {
        let hud = JGProgressHUD()
        let view = JGProgressHUDSuccessIndicatorView()
        hud.indicatorView = view
        hud.textLabel.text = "提交成功"
        return hud
    }()
    
    private var order: Order!
    
    init(order: Order) {
        super.init(nibName: nil, bundle: nil)
        self.order = order
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupUI()
    }
    
    private func setupNavBar() {
        title = "確認訂單"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let confirm = UIBarButtonItem(title: "提交訂單", style: .plain, target: self, action: #selector(confirmTapped))
        navigationItem.rightBarButtonItems = [confirm]
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.fillSuperviewSafeAreaLayoutGuide()
    }
    
    @objc private func confirmTapped() {
        hud.show(in: view, animated: true)
        
        RealmManager.shared.save(order)
        for item in order.items {
            if let index = CartManager.shared.getCurrentCommodities().firstIndex(where: {
                ($0.item?.commodityName == item.commodityName) && ($0.item?.commodityCreateDateString == item.commodityCreateDateString)
            }) {
                CartManager.shared.deleteAt(index)
            }
        }
        
        hud.dismiss(afterDelay: 1.5)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7, execute: {
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
}

extension PaymentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommodityListCell.cellId, for: indexPath) as! CommodityListCell
        let item = order.items[indexPath.item]
        cell.vm = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommodityListCell.height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text  = "$\(order.getTotalPrice())"
        footer.addSubview(titleLabel)
        titleLabel.centerInSuperview()
        return footer
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}
