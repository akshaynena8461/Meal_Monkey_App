
import UIKit

class PaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblCardNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        EditStyle.setborder(textfields: [btnDelete], cornerRadious: 15)
        btnDelete.layer.borderColor = UIColor.loginbtnbg.cgColor
        btnDelete.layer.borderWidth = 1.0
    }

    @IBAction func btnDeleteClick(_ sender: Any) {
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configPaymentCell(payment:PaymentModel){
        lblCardNumber.text = "\(payment.intCardNumber ?? 0)"
    }
    

}
