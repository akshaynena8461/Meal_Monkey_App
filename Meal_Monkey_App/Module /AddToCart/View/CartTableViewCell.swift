import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!

    var onDelete: (() -> Void)?
    var onHeartTapped: (() -> Void)?

    var products: ProductModel?

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
        imgProduct.image = UIImage(named: product.strProductImage)
        lblProductTitle.text = product.strProductName
        lblType.text = "\(product.objProductType)"
        lblCategory.text = "\(product.objProductCategory)"
        lblPrice.text = "\(product.doubleProductPrice)"
        lblQty.text = "Qty : \(product.intProductQty ?? 1)"
        btnLike.isHidden = true
    }

    func configWishListCell(product: ProductModel) {
        imgProduct.image = UIImage(named: product.strProductImage)
        lblProductTitle.text = product.strProductName
        lblType.text = "\(product.objProductType)"
        lblCategory.text = "\(product.objProductCategory)"
        lblPrice.text = "\(product.doubleProductPrice)"
        lblQty.text = "Qty : \(product.intProductQty ?? 1)"
        btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        btnDelete.isHidden = true
    }

    @IBAction func btnLikeClick(_ sender: Any) {
        onHeartTapped?()
    }

}
