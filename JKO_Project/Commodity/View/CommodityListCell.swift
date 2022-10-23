import UIKit
import LBTATools

class CommodityListCell: UITableViewCell {
    static let cellId = "CommodityListCell"
    static let height: CGFloat = 90
    
    private let commodityImageView = UIImageView(image: nil)
    private let nameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .left, numberOfLines: 1)
    private let descriptionLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 13), textColor: .black, textAlignment: .left, numberOfLines: 1)
    private let priceLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 1)
    private let dateLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 11), textColor: .black, textAlignment: .right, numberOfLines: 1)
    
    var vm: CommodityListCellViewModel? {
        didSet {
            commodityImageView.image = UIImage(data: vm!.commodityImageData)
            nameLabel.text = vm!.commodityName
            descriptionLabel.text = vm!.commodityDescription
            priceLabel.text = vm!.commodityPriceString
            dateLabel.text = vm!.commodityCreateDateString
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
        selectionStyle = .none
        addSubview(commodityImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(dateLabel)
        
        commodityImageView.translatesAutoresizingMaskIntoConstraints = false
        commodityImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            commodityImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            commodityImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            commodityImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            commodityImageView.widthAnchor.constraint(equalTo: heightAnchor)
        ])
        
        dateLabel.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 8))
        
        priceLabel.centerYToSuperview()
        priceLabel.anchor(top: nil, leading: commodityImageView.trailingAnchor, bottom: nil, trailing: dateLabel.leadingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8))
        
        nameLabel.anchor(top: nil, leading: commodityImageView.trailingAnchor, bottom: priceLabel.topAnchor, trailing: dateLabel.leadingAnchor, padding: .init(top: 0, left: 8, bottom: 8, right: 8))
                
        
        descriptionLabel.anchor(top: priceLabel.bottomAnchor, leading: commodityImageView.trailingAnchor, bottom: nil, trailing: dateLabel.leadingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))

    }
}
