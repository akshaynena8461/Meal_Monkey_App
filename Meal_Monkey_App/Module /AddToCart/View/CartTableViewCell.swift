import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var btnDelete: UIButton!

    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCategory: UILabel!

    @IBOutlet weak var imgProduct: UIImageView!
    
    var onDelete: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        imgProduct.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func btnDeleteClick(_ sender: Any) {
        onDelete?()
    }

    func configCartCell(product: ProductModel) {
        lblProductTitle.text = product.strProductName
        lblType.text = "\(product.objProductType)"
        lblCategory.text = "\(product.objProductCategory)"
        lblPrice.text = "\(product.doubleProductPrice)"
        lblQty.text = "Qty : \(product.intProductQty ?? 0)"
    }

}
