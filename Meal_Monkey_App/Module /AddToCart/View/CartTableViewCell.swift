import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var btnDelete: UIButton!

    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCategory: UILabel!

    @IBOutlet weak var imgProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        EditStyle.setborder(textfields: [imgProduct], cornerRadious: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func btnDeleteClick(_ sender: Any) {

    }

    func configCartCell(product: ProductModel) {
        lblProductTitle.text = product.strProductName
        lblCategory.text = "\(product.objProductCategory)"
        lblPrice.text = "\(product.doubleProductPrice)"
        lblDescription.text = product.strProductDescription
        lblQty.text = "Qty : \(product.intProductQty ?? 0)"
    }

}
