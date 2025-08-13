import UIKit

class PaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblCardNumber: UILabel!

    var onDelete: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        EditStyle.setborder(textfields: [btnDelete], cornerRadious: 15)
        btnDelete.layer.borderColor = UIColor.loginbtnbg.cgColor
        btnDelete.layer.borderWidth = 1.0
    }

    @IBAction func btnDeleteClick(_ sender: Any) {
        onDelete?()

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
