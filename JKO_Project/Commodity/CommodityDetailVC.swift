import UIKit
import LBTATools

class CommodityDetailVC: UIViewController {
    let commodityImageView = UIImageView(image: nil)
    let nameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let descriptionLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 13), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let priceLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let dateLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 11), textColor: .black, textAlignment: .right, numberOfLines: 0)
    
    var commodity: GeneralCommidity? {
        didSet {
            commodityImageView.image = UIImage(named: commodity?.imageName ?? "")
            nameLabel.text = commodity?.name
            descriptionLabel.text = commodity?.description
            priceLabel.text = "\(commodity?.price ?? -1)"

            let timeIntervalSince1970 = commodity?.createAt ?? 0
            let timeInterval = TimeInterval(timeIntervalSince1970)
            let date = Date(timeIntervalSince1970: timeInterval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
            let dayString = dateFormatter.string(from: date)
            dateLabel.text = dayString
        }
    }
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        commodityImageView.contentMode = .scaleAspectFit
        
        view.addSubview(commodityImageView)
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        
        commodityImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 180))
        
        nameLabel.anchor(top: commodityImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        
        priceLabel.anchor(top: nameLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        
        descriptionLabel.anchor(top: priceLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))
    }
}
