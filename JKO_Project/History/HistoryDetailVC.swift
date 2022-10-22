import UIKit
import LBTATools
import RealmSwift

class HistoryDetailVC: UIViewController {
    private var items: List<GeneralCommidity>!
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    init(items: List<GeneralCommidity>) {
        super.init(nibName: nil, bundle: nil)
        self.items = items
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUI()
    }
    
    private func setupNavBar() {
        title = "訂單資訊"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.fillSuperviewSafeAreaLayoutGuide()
    }
}

extension HistoryDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
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