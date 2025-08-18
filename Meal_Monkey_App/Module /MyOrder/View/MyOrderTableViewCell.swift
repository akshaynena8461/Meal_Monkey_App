import UIKit

class MyOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configMyOrderDetailCell(product:ProductModel){
        lblProductName.text = "\(product.strProductName) x"
        lblProductQty.text = "\(product.intProductQty ?? 1)"
        lblProductPrice.text = "$\(product.doubleProductPrice * Double(product.intProductQty ?? 1))"
    }
}
