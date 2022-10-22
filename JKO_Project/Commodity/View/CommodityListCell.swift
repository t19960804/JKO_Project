import UIKit
import LBTATools

class CommodityListCell: UITableViewCell {
    static let cellId = "CommodityListCell"
    
    let commodityImageView = UIImageView(image: nil)
    let nameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .left, numberOfLines: 1)
    let descriptionLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 13), textColor: .black, textAlignment: .left, numberOfLines: 1)
    let priceLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 1)
    let dateLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 11), textColor: .black, textAlignment: .right, numberOfLines: 1)
    
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(commodityImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(dateLabel)
        
        commodityImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 50, height: 50))
        
        dateLabel.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 8))
        
        priceLabel.centerYToSuperview()
        priceLabel.anchor(top: nil, leading: commodityImageView.trailingAnchor, bottom: nil, trailing: dateLabel.leadingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8))
        
        nameLabel.anchor(top: nil, leading: commodityImageView.trailingAnchor, bottom: priceLabel.topAnchor, trailing: dateLabel.leadingAnchor, padding: .init(top: 0, left: 8, bottom: 8, right: 8))
                
        
        descriptionLabel.anchor(top: priceLabel.bottomAnchor, leading: commodityImageView.trailingAnchor, bottom: nil, trailing: dateLabel.leadingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))

    }
}
