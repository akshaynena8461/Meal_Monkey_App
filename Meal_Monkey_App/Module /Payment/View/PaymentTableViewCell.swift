import UIKit

class PaymentTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var btnDelete: UIButton!       // Delete button for the payment card
    @IBOutlet weak var lblCardNumber: UILabel!    // Label showing masked card number

    // Closure that will be triggered when delete button is tapped
    var onDelete: (() -> Void)?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        // Apply border styling to the delete button
        EditStyle.setborder(textfields: [btnDelete], cornerRadious: 15)
        btnDelete.layer.borderColor = UIColor.loginbtnbg.cgColor
        btnDelete.layer.borderWidth = 1.0
    }

    // MARK: - Actions
    @IBAction func btnDeleteClick(_ sender: Any) {
        // Trigger the delete callback when button is tapped
        onDelete?()
    }

    // MARK: - Selection Handling
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Configure Cell
    func configPaymentCell(payment: PaymentModel) {
        // Mask all but last 4 digits of the card number
        if let cardNumber = payment.strCardNumber, cardNumber.count >= 4 {
            let last4 = cardNumber.suffix(4)
            lblCardNumber.text = "**** **** **** \(last4)"
        } else {
            // Display fallback text if card number is invalid
            lblCardNumber.text = "Invalid Card"
        }
    }
}
