import UIKit

class MyOrderTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblProductPrice: UILabel!  // Displays total price for the product
    @IBOutlet weak var lblProductQty: UILabel!    // Displays quantity of the product
    @IBOutlet weak var lblProductName: UILabel!   // Displays product name

    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code can go here if needed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state if needed
    }
    
    // MARK: - Configure Cell
    /// Populates the cell with product data
    /// - Parameter product: ProductModel instance containing product details
    func configMyOrderDetailCell(product: ProductModel) {
        // Show product name followed by "x" to indicate multiplication with quantity
        lblProductName.text = "\(product.strProductName) x"
        
        // Display the quantity of the product, defaulting to 1 if nil
        lblProductQty.text = "\(product.intProductQty ?? 1)"
        
        // Calculate total price (price * quantity) and display it with a "$" symbol
        lblProductPrice.text = "$\(product.doubleProductPrice * Double(product.intProductQty ?? 1))"
    }
}
