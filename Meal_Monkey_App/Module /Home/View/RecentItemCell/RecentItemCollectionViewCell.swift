import UIKit

class RecentItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblNumberOfRatings: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRecentItemName: UILabel!
    @IBOutlet weak var imgRecentItem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgRecentItem.layer.cornerRadius = 10
    }

}
