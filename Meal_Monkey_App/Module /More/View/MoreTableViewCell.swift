import UIKit

// MARK: - MoreTableViewCell
// Custom UITableViewCell for displaying a "More" menu item
class MoreTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var btnArrow: UIButton!  // Button for navigation arrow
    @IBOutlet weak var mainView: UIView!  // Main container view for the cell
    @IBOutlet weak var lblTitle: UILabel!  // Label to display the menu title
    @IBOutlet weak var imgView: UIImageView!  // ImageView to display menu icon

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        // Set border for image view
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor =
            UIColor(named: "More_icons_border_color")?.cgColor

        // Round corners of the main view
        mainView.layer.cornerRadius = 7

        // Round button (arrow) fully
        btnArrow.layer.cornerRadius = 50

        // Make image view circular
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        imgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Configuration
    /// Configures the cell with a MoreModel object
    /// - Parameter more: MoreModel instance containing title and image
    func configMoreCell(more: MoreModel) {
        let titles = [
            Main.More.payment,
            Main.More.myOrders,
            Main.More.notifications,
            Main.More.inbox,
            Main.More.aboutUs,
            Main.More.wishlist,
            Main.More.changeLanguage,
            Main.More.changeTheme,
        ]

        if let tag = more.intTag, tag < titles.count {
            lblTitle.text = titles[tag]
        } else {
            lblTitle.text = ""
        }

        imgView.image = UIImage(named: more.strImage ?? "")  // Set icon image
    }
}
