import UIKit
import LBTATools
import JGProgressHUD

class CommodityDetailVC: UIViewController {
    private let commodityImageView = UIImageView(image: nil)
    
    private let nameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .left, numberOfLines: 0)
    
    private let descriptionLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 13), textColor: .black, textAlignment: .left, numberOfLines: 0)
    
    private let priceLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 0)
    
    private let hud: JGProgressHUD = {
        let hud = JGProgressHUD()
        let view = JGProgressHUDSuccessIndicatorView()
        hud.indicatorView = view
        hud.textLabel.text = "加入成功"
        return hud
    }()
    
    private var vm: CommodityListCellViewModel!

    init(vm: CommodityListCellViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.vm = vm
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
        CartManager.shared.addCommodities([vm])
        navigationController?.pushViewController(CartVC(), animated: true)
    }
    
    @objc private func addToCartTapped() {
        hud.show(in: view, animated: true)
        
        CartManager.shared.addCommodities([vm])
        
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
        
        commodityImageView.image = UIImage(data: vm.commodityImageData)
        nameLabel.text = vm.commodityName
        descriptionLabel.text = vm.commodityDescription
        priceLabel.text = vm.commodityPriceString
    }
}
