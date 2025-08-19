import UIKit

// Custom UITableViewCell class for displaying About Us, Notification, and Inbox data
class AboutUsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets (UI Elements from Storyboard/XIB)
    
    @IBOutlet weak var lblRightTitleWidth: NSLayoutConstraint! // Constraint to control right-side label width dynamically
    @IBOutlet weak var btnStar: UIButton!                      // Star button (used in Inbox cell)
    @IBOutlet weak var lblRightsideTitle: UILabel!             // Right-side title label (e.g., Date or Time)
    @IBOutlet weak var lblTitle2: UILabel!                     // Secondary text label (e.g., Notification time, Inbox description)
    @IBOutlet weak var lblTitle: UILabel!                      // Main title/description label
    
    @IBOutlet weak var imgDotRightConstraint: NSLayoutConstraint! // Constraint to adjust dot/image spacing
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code when the cell is loaded from storyboard/XIB
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Called when the cell is selected/deselected
    }
    
    // MARK: - IBActions
    
    @IBAction func btnStarClick(_ sender: Any) {
        // Action triggered when star button is tapped
        // (You can add favorite/unfavorite functionality here)
    }
    
    // MARK: - Cell Configuration Methods
    
    /// Configure cell for "About Us" section
    func configaboutcell(about: AboutModel) {
        lblTitle.text = about.strText           // Set About Us text
        lblTitle2.isHidden = true               // Hide secondary text
        lblRightsideTitle.isHidden = true       // Hide right-side label
        btnStar.isHidden = true                 // Hide star button
        lblRightTitleWidth.constant = 0         // Collapse right label width
    }

    /// Configure cell for "Notifications" section
    func configNotificationcell(about: AboutModel) {
        lblTitle.text = about.strText           // Set notification text
        btnStar.isHidden = true                 // Star not used in notifications
        lblRightsideTitle.isHidden = true       // Hide right-side label
        lblTitle2.text = about.strTimezone      // Show notification time
        imgDotRightConstraint.constant = 35     // Adjust dot/icon spacing
    }

    /// Configure cell for "Inbox" section
    func configInboxcell(about: AboutModel) {
        lblTitle.text = about.strText           // Set inbox title (e.g., "Order Update")
        btnStar.isHidden = false                // Show star button
        lblRightsideTitle.text = about.strRightSideText // Show right-side text (e.g., Date)
        lblTitle2.text = about.strText2         // Show inbox message/description
    }
}
