import UIKit

class CardViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var stackCard: UIStackView!   // Stack view containing card UI
    @IBOutlet weak var lblCardNumber: UILabel!   // Label to display masked card number
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Optional: Additional UI setup after loading from nib
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Optional: Configure appearance when cell is selected
    }
    
    // MARK: - Cell Configuration
    /// Configure the payment cell with a PaymentModel
    /// - Parameter payment: PaymentModel containing card information
    func configPaymentCell(payment: PaymentModel) {
        if let cardNumber = payment.strCardNumber, cardNumber.count >= 4 {
            // Show only last 4 digits, mask the rest
            let last4 = cardNumber.suffix(4)
            lblCardNumber.text = "**** **** **** \(last4)"
        } else {
            // Handle invalid or missing card numbers
            lblCardNumber.text = "Invalid Card"
        }
    }
}
