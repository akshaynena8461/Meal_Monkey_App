
import UIKit

class PopularItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblNumberOfRating: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
