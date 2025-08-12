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

    func configOrderListCell(product: OrderModel) {
        lblOrderId.text = "Order Id: \(product.intOrderId ?? 0)"
        if let products = product.arrProducts, !products.isEmpty {
            let names = products.map { $0.strProductName }.joined(
                separator: ", "
            )
            lblProductsName.text = names
        }

        lblTotalPrice.text = "Total: ₹ \(product.dblTotalAmount ?? 0)"
    }
}
