import UIKit

class RecentItemCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblProductType: UILabel!          // Label to show product type (Food, Dessert, etc.)
    @IBOutlet weak var lblNumberOfRatings: UILabel!      // Label to show total number of ratings
    @IBOutlet weak var lblRatings: UILabel!              // Label to show average rating
    @IBOutlet weak var btnStar: UIButton!                // Star button (can be used for favorite or rating)
    @IBOutlet weak var lblRecentItemName: UILabel!       // Label to display product name
    @IBOutlet weak var imgRecentItem: UIImageView!       // ImageView to display product image
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Round the corners of the product image for a better look
        imgRecentItem.layer.cornerRadius = 10
        imgRecentItem.clipsToBounds = true
    }
    
    // MARK: - Configure Cell
    /// Configures the cell with a recent product
    /// - Parameter recentItem: ProductModel object containing product details
    func configureRecentItemCell(recentItem: ProductModel) {
        lblRecentItemName.text = recentItem.strProductName
        lblProductType.text = recentItem.objProductType.rawValue
        lblRatings.text = "\(recentItem.floatProductRating)"
        lblNumberOfRatings.text = "\(recentItem.intTotalNumberOfRatings)"
        imgRecentItem.image = UIImage(named: recentItem.strProductImage)
    }
}
