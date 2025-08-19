import UIKit

class OTPViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var btnDoNotReceive: UIButton!   // Button to resend OTP
    @IBOutlet weak var btnNext: UIButton!           // Button to proceed after entering OTP
    @IBOutlet weak var txtDigit1: UITextField!      // First digit input
    @IBOutlet weak var txtDigit2: UITextField!      // Second digit input
    @IBOutlet weak var txtDigit3: UITextField!      // Third digit input
    @IBOutlet weak var txtDigit4: UITextField!      // Fourth digit input

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Array of all OTP text fields for easier manipulation
        let allTextFields = [txtDigit1!, txtDigit2!, txtDigit3!, txtDigit4!]

        // Set custom border style for OTP text fields
        EditStyle.setOTPtextFieldborder(textfields: allTextFields)

        // Set rounded corner style for the Next button
        EditStyle.setborder(textfields: [btnNext], cornerRadious: 28)

        // Configure each OTP text field
        for tf in allTextFields {
            tf.delegate = self            // Set delegate to handle input events
            tf.keyboardType = .numberPad  // Numeric keypad for OTP entry
            tf.textAlignment = .center    // Center the text for each digit
        }
    }

    // MARK: - Button Actions

    /// Action for the Next button - navigates to NewPasswordViewController
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

    /// Action for "Did not receive OTP" button - shows a confirmation alert
    @IBAction func btnDoNotReceiveClick(_ sender: Any) {
        UIAlertController.showAlert(
            title: "Success",
            message: "OTP Sent Successfully",
            viewController: self
        )
    }
}
