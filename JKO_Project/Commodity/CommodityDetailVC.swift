import UIKit
import LBTATools
import JGProgressHUD

class CommodityDetailVC: UIViewController {
    let commodityImageView = UIImageView(image: nil)
    let nameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let descriptionLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 13), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let priceLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let dateLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 11), textColor: .black, textAlignment: .right, numberOfLines: 0)
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD()
        let view = JGProgressHUDSuccessIndicatorView()
        hud.indicatorView = view
        hud.textLabel.text = "加入成功"
        return hud
    }()
    
    private var commodity: GeneralCommidity!

    init(commodity: GeneralCommidity) {
        super.init(nibName: nil, bundle: nil)
        self.commodity = commodity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupNavBar()
        setupUI()
    }
    
    private func setupNavBar() {
        title = "商品詳情"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let buy = UIBarButtonItem(title: "立即購買", style: .plain, target: self, action: #selector(buyTapped))
        let addToCart = UIBarButtonItem(title: "加入購物車", style: .plain, target: self, action: #selector(addToCartTapped))
        navigationItem.rightBarButtonItems = [addToCart, buy]
    }
    
    @objc private func buyTapped() {
        CartManager.shared.add([self.commodity])
        let vc = CartVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func addToCartTapped() {
        hud.show(in: view, animated: true)
        
        CartManager.shared.add([self.commodity])
        
        hud.dismiss(afterDelay: 1.5)
    }
    
    private func setupUI() {
        commodityImageView.contentMode = .scaleAspectFit
        
        view.addSubview(commodityImageView)
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(hud)
        
        commodityImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 180))
        
        nameLabel.anchor(top: commodityImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        
        priceLabel.anchor(top: nameLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        
        descriptionLabel.anchor(top: priceLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        
        hud.centerInSuperview()
        
        commodityImageView.image = UIImage(named: commodity.imageName)
        nameLabel.text = commodity.name
        descriptionLabel.text = commodity.descript
        priceLabel.text = "\(commodity.price)"

        let timeIntervalSince1970 = commodity.createAt
        let timeInterval = TimeInterval(timeIntervalSince1970)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dayString = dateFormatter.string(from: date)
        dateLabel.text = dayString
    }
}
