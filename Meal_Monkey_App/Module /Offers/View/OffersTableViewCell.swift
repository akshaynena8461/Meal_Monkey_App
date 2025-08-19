import UIKit

/// Custom UITableViewCell to display an Offer
class OffersTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imgOffers: UIImageView!   // Image view for the offer image
    @IBOutlet weak var lblTitle2: UILabel!       // Secondary title or description (e.g., ratings, cuisine)
    @IBOutlet weak var lblRating: UILabel!       // Rating label
    @IBOutlet weak var imgStar: UIImageView!     // Star image for rating icon
    @IBOutlet weak var lblTitle: UILabel!        // Primary title (e.g., restaurant name)

    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Additional initialization if needed
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view when cell is selected if needed
    }
    
    // MARK: - Configuration
    /// Configures the cell with the provided OfferModel
    /// - Parameter offer: The OfferModel object to display
    func configOfferCell(offer: OfferModel) {
        // Set the primary title
        lblTitle.text = offer.strTitle
        
        // Set the rating, defaulting to 0.0 if nil
        lblRating.text = "\(offer.floatRating ?? 0.0)"
        
        // Set the secondary title/description
        lblTitle2.text = offer.strTitle2
        
        // Set the image for the offer
        imgOffers.image = UIImage(named: "\(offer.strImage ?? "")")
    }
}
