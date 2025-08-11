import UIKit

class OffersTableViewCell: UITableViewCell {
    @IBOutlet weak var imgOffers: UIImageView!

    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configOfferCell(offer: OfferModel) {
        lblTitle.text = offer.strTitle
        lblRating.text = "\(offer.floatRating ?? 0.0)"
        lblTitle2.text = offer.strTitle2
        imgOffers.image = UIImage(named: "\(offer.strImage ?? "")")
    }
}
