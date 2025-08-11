import UIKit

class MostPopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnStars: UIButton!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgMostPoularProduct: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgMostPoularProduct.layer.cornerRadius = 10
    }

    func congigMostPopularCell(product: ProductModel) {
        lblProductName.text = product.strProductName
        lblRating.text = "\(product.floatProductRating)"
        lblCategory.text = product.strProductName
        imgMostPoularProduct.image = UIImage(named: product.strProductImage)
    }
}
