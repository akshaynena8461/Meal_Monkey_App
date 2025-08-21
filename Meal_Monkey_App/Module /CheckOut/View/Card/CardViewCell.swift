import UIKit

class CardViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnSelectCard: UIButton!
    @IBOutlet weak var stackCard: UIStackView!  // Stack view containing card UI
    @IBOutlet weak var lblCardNumber: UILabel!  // Label to display masked card number

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Optional: Additional UI setup after loading from nib
        mainView.layer.cornerRadius = 6
        mainView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Optional: Configure appearance when cell is selected
    }

    // MARK: - Cell Configuration
    /// Configure the payment cell with a PaymentModel
    /// - Parameter payment: PaymentModel containing card information
    func configPaymentCell(payment: PaymentModel) {
        // Convert card number to string
        let cardNumberString = String(payment.intCardNumber ?? 0)

        if cardNumberString.count >= 4 {
            let last4 = cardNumberString.suffix(4)
            lblCardNumber.text = "**** **** **** \(last4)"
        } else {
            // Display fallback text if card number is invalid
            lblCardNumber.text = "Invalid Card"
        }
    }
}
