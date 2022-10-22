import UIKit
import LBTATools

class HistoryVC: UIViewController {
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.selectionStyle = .none
        let orders = RealmManager.shared.fetch(Order.self)
        let timeIntervalSince1970 = orders[indexPath.item].createAt
        let timeInterval = TimeInterval(timeIntervalSince1970)
        let date = Date(timeIntervalSince1970: timeInterval)
        cell.textLabel?.text = date.toString(format: "yyyy/MM/dd HH:mm")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

