
import UIKit

class CardViewCell: UITableViewCell {

    @IBOutlet weak var stackCard: UIStackView!
    @IBOutlet weak var lblCardNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configPaymentCell(payment: PaymentModel) {
        if let cardNumber = payment.strCardNumber, cardNumber.count >= 4 {
            let last4 = cardNumber.suffix(4)
            lblCardNumber.text = "**** **** **** \(last4)"
        } else {
            lblCardNumber.text = "Invalid Card"
        }
    }
}
