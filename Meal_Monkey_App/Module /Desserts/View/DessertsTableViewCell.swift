import UIKit

class DessertsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgDessert: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configDessertCell(dessert: ProductModel) {
        lblTitle.text = dessert.strProductName
        lblTitle2.text = "\(dessert.objProductType)"
        lblRating.text = "\(dessert.floatProductRating)"
        imgDessert.image = UIImage(named: dessert.strProductImage)
    }
}
