import UIKit

/// Custom UITableViewCell to display order summary
class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgOrder: UIImageView!       // Image of first product in the order
    @IBOutlet weak var lblTotalPrice: UILabel!     // Label to show total price of the order
    @IBOutlet weak var lblProductsName: UILabel!   // Label to show names of all products
    @IBOutlet weak var lblOrderId: UILabel!        // Label to show order ID

    override func awakeFromNib() {
        super.awakeFromNib()
        // Make the order image view corners rounded
        imgOrder.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /// Configures the cell with product data for a particular order
    /// - Parameters:
    ///   - products: Array of ProductModel for this order
    ///   - index: The index of the order (used for order ID)
    func configOrderListCell(products: [ProductModel], index: Int) {
        // Display order ID
        lblOrderId.text = "Order Id: \(index + 1)"

        // Set image as the first product image or a placeholder if empty
        if let firstProduct = products.first {
            imgOrder.image = UIImage(named: firstProduct.strProductImage)
        } else {
            imgOrder.image = UIImage(named: "placeholder")
        }

        // Join all product names with commas
        let names = products.map { $0.strProductName }.joined(separator: ", ")
        lblProductsName.text = names.isEmpty ? "No products" : names

        // Calculate total price of the order
        let total = products.reduce(0) {
            $0 + $1.doubleProductPrice * Double($1.intProductQty ?? 1)
        }
        lblTotalPrice.text = String(format: "Total: $ %.2f", total)
    }
}
