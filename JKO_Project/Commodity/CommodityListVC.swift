import UIKit
import LBTATools
import Combine

class CommodityListVC: UIViewController {
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(CommodityListCell.self, forCellReuseIdentifier: CommodityListCell.cellId)
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    private let vm = CommodityListViewModel()
    
    private var dataSourceSubscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupUI()
        setupSubscriptions()
        vm.fetchData()
    }
    
    fileprivate func setupSubscriptions(){
        dataSourceSubscription = vm.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
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
        navigationController?.pushViewController(CartVC(), animated: true)
    }
    
    @objc private func historyTapped() {
        navigationController?.pushViewController(HistoryVC(), animated: true)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.fillSuperviewSafeAreaLayoutGuide()
    }
}

extension CommodityListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommodityListCell.cellId, for: indexPath) as! CommodityListCell
        cell.vm = vm.items[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommodityListCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommodityDetailVC(vm: vm.items[indexPath.item])
        navigationController?.pushViewController(vc, animated: true)
    }
}
