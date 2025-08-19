import UIKit

class PopularItemCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblProductName: UILabel!     // Label for displaying product name
    @IBOutlet weak var lblCategory: UILabel!        // Label for displaying product category
    @IBOutlet weak var lblDescription: UILabel!     // Label for product description (if needed)
    @IBOutlet weak var lblNumberOfRating: UILabel!  // Label to show total number of ratings
    @IBOutlet weak var lblRating: UILabel!          // Label to show numeric rating (e.g., 4.5)
    @IBOutlet weak var imgProduct: UIImageView!     // ImageView for product image

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Any additional UI setup can be done here, e.g., rounding corners, shadows
    }
    
    // MARK: - Configure Cell
    /// Configures the cell with product data
    /// - Parameter product: ProductModel containing product information
    func configPopularProduct(product: ProductModel) {
        lblProductName.text = product.strProductName               // Set product name
        lblRating.text = "\(product.floatProductRating)"           // Set numeric rating
        lblCategory.text = "\(product.objProductCategory)"        // Set category (uses enum raw value)
        imgProduct.image = UIImage(named: product.strProductImage) // Set product image
        // lblNumberOfRating.text can be set as "\(product.intTotalNumberOfRatings)" if needed
        // lblDescription.text can be set as product.strProductDescription if you want to show description
    }
}
