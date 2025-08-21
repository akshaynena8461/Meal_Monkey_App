import UIKit

class MostPopularCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblProductName: UILabel!       // Product name label
    @IBOutlet weak var btnStars: UIButton!           // Stars button (can show ratings visually)
    @IBOutlet weak var lblType: UILabel!         // Product category label
    @IBOutlet weak var lblDescription: UILabel!      // Product description label
    @IBOutlet weak var lblRating: UILabel!           // Numeric rating label
    @IBOutlet weak var imgMostPoularProduct: UIImageView! // Product image

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Round the corners of the product image for better UI
        imgMostPoularProduct.layer.cornerRadius = 10
        imgMostPoularProduct.clipsToBounds = true
    }

    // MARK: - Configure Cell
    /// Configures the collection view cell with a ProductModel
    /// - Parameter product: ProductModel instance containing product details
    func congigMostPopularCell(product: ProductModel) {
        lblProductName.text = product.strProductName           // Set product name
        lblRating.text = "\(product.floatProductRating)"       // Show numeric rating
        lblType.text = "\(product.objProductType)"             // Show product category
        imgMostPoularProduct.image = UIImage(named: product.strProductImage) // Set product image
    }
}
