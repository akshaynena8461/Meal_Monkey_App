import UIKit

class CartTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var btnLike: UIButton!           // Heart button for wishlist
    @IBOutlet weak var btnDelete: UIButton!         // Delete button for cart
    @IBOutlet weak var lblProductTitle: UILabel!    // Label for product name
    @IBOutlet weak var lblQty: UILabel!             // Label for product quantity
    @IBOutlet weak var lblPrice: UILabel!           // Label for product price
    @IBOutlet weak var lblType: UILabel!            // Label for product type
    @IBOutlet weak var lblCategory: UILabel!        // Label for product category
    @IBOutlet weak var imgProduct: UIImageView!     // ImageView for product image

    // MARK: - Callbacks
    var onDelete: (() -> Void)?          // Closure called when delete button is tapped
    var onHeartTapped: (() -> Void)?     // Closure called when heart button is tapped

    // MARK: - Model
    var products: ProductModel?          // The product data associated with this cell

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Set corner radius for product image
        imgProduct.layer.cornerRadius = 10
        imgProduct.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Optional: configure appearance when cell is selected
    }

    // MARK: - IBActions
    @IBAction func btnDeleteClick(_ sender: Any) {
        // Trigger the delete callback
        onDelete?()
    }

    @IBAction func btnLikeClick(_ sender: Any) {
        // Trigger the heart/wishlist callback
        onHeartTapped?()
    }

    // MARK: - Cell Configuration
    enum ProductCellType {
        case cart
        case wishList
    }

    /// Configure the cell with product data and type (cart or wishlist)
    /// - Parameters:
    ///   - product: ProductModel object containing data
    ///   - type: Type of cell to determine which buttons are shown
    func configCell(product: ProductModel, type: ProductCellType) {
        // Set product image
        imgProduct.image = UIImage(named: product.strProductImage)
        // Set product details
        lblProductTitle.text = product.strProductName
        lblType.text = "\(product.objProductType)"
        lblCategory.text = "\(product.objProductCategory)"
        lblPrice.text = "\(product.doubleProductPrice * Double(product.intProductQty ?? 1))"
        lblQty.text = "\(product.intProductQty ?? 1)"  // Default quantity to 1 if nil

        // Configure buttons based on cell type
        switch type {
        case .cart:
            btnLike.isHidden = true      // Hide heart button for cart
            btnDelete.isHidden = false   // Show delete button
        case .wishList:
            btnLike.isHidden = false
            btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal) // Show heart
            btnDelete.isHidden = true    // Hide delete button for wishlist
        }
    }
}
