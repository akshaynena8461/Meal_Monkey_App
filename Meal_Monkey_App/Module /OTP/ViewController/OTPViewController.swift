import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var btnDoNotReceive: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtDigit4: UITextField!
    @IBOutlet weak var txtDigit3: UITextField!
    @IBOutlet weak var txtDigit2: UITextField!
    @IBOutlet weak var txtDigit1: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let allviews = [txtDigit1!, txtDigit2!, txtDigit3!, txtDigit4!]

        EditStyle.setOTPtextFieldborder(textfields: [
            txtDigit1,
            txtDigit2,
            txtDigit3,
            txtDigit4,
        ])
        EditStyle.setborder(textfields: [btnNext], cornerRadious: 28)

        for tf in allviews {
            tf.delegate = self
            tf.keyboardType = .numberPad
            tf.textAlignment = .center
        }

    }

    @IBAction func btnNextClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        if let newPasswordVc = storyboard.instantiateViewController(
            withIdentifier: "NewPasswordViewController"
        ) as? NewPasswordViewController {
            self.navigationController?.pushViewController(
                newPasswordVc,
                animated: true
            )
        }
    }

    @IBAction func btnDoNotReceiveClick(_ sender: Any) {
        UIAlertController.showAlert(
            title: "Success",
            message: "OTP Sent Successfully",
            viewController: self
        )
    }

}
