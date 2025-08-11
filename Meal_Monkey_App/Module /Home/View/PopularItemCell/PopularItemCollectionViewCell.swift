import UIKit

class PopularItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblNumberOfRating: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configPopularProduct(product: ProductModel) {
        lblProductName.text = product.strProductName
        lblRating.text = "\(product.floatProductRating)"
        lblCategory.text = "\(product.objProductCategory)"
        imgProduct.image = UIImage(named: product.strProductImage)
    }
}
