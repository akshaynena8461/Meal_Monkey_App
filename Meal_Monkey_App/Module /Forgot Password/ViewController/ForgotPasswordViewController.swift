import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var btnsend: UIButton!
    @IBOutlet weak var txtemail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EditStyle.setborder(textfields: [txtemail, btnsend], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtemail], paddingWidth: 34)
    }

    @IBAction func btnsendclick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(
            withIdentifier: "OTPViewController"
        ) as? OTPViewController {
            self.navigationController?.pushViewController(
                signUpVC,
                animated: true
            )
        }
    }
}
