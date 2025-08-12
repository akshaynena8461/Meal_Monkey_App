import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgOrder: UIImageView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblProductsName: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgOrder.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configOrderListCell(products: [ProductModel], index: Int) {
        // Order ID
        lblOrderId.text = "Order Id: \(index + 1)"
        
        // Set first product's image (or a default)
        if let firstProduct = products.first {
            imgOrder.image = UIImage(named: firstProduct.strProductImage)
        } else {
            imgOrder.image = UIImage(named: "placeholder")
        }
        
        // Join product names
        let names = products.map { $0.strProductName }.joined(separator: ", ")
        lblProductsName.text = names.isEmpty ? "No products" : names
        
        // Calculate total price
        let total = products.reduce(0) { $0 + $1.doubleProductPrice * Double($1.intProductQty ?? 1) }
        lblTotalPrice.text = String(format: "Total: $ %.2f", total)
    }

}
