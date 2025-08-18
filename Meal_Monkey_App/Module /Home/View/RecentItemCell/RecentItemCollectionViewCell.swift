import UIKit

class RecentItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var lblNumberOfRatings: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblRecentItemName: UILabel!
    @IBOutlet weak var imgRecentItem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgRecentItem.layer.cornerRadius = 10
    }
    
    func configureRecentItemCell(recentItem: ProductModel) {
        lblRecentItemName.text = recentItem.strProductName
        lblProductType.text = recentItem.objProductType.rawValue
        lblRatings.text = "\(recentItem.floatProductRating)"
        lblNumberOfRatings.text = "\(recentItem.intTotalNumberOfRatings)"
        imgRecentItem.image = UIImage(named: recentItem.strProductImage)
    }
}
