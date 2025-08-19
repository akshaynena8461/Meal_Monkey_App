import UIKit

class CaseOnDeliveryCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var stackCaseOnDeleviery: UIStackView! // Stack view containing UI for Cash on Delivery option

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Optional: Customize UI after the cell has been loaded from nib
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Optional: Configure appearance when cell is selected
    }
}
