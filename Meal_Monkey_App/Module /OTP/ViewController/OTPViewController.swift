import OTPFieldView
import UIKit

class OTPViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var btnDoNotReceive: UIButton!  // Button to resend OTP
    @IBOutlet weak var btnNext: UIButton!  // Button to proceed after entering OTP
    @IBOutlet weak var txtDigit1: UITextField!  // First digit input
    @IBOutlet weak var txtDigit2: UITextField!  // Second digit input
    @IBOutlet weak var txtDigit3: UITextField!  // Third digit input
    @IBOutlet weak var txtDigit4: UITextField!  // Fourth digit input
    @IBOutlet weak var otpView: UIView!

    let otpFieldView = OTPFieldView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set rounded corner style for the Next button
        EditStyle.setborder(textfields: [btnNext], cornerRadious: 28)

        otpView.backgroundColor = .white

        otpFieldView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.frame.size.width - 50,
            height: 60
        )
        otpFieldView.fieldsCount = 4
        otpFieldView.fieldBorderWidth = 2
        otpFieldView.defaultBorderColor = .lightGray
        otpFieldView.filledBorderColor = .systemBlue
        otpFieldView.cursorColor = .systemBlue
        otpFieldView.displayType = .roundedCorner
        otpFieldView.fieldSize = 40
        otpFieldView.separatorSpace = 20
        otpFieldView.delegate = self

        otpView.addSubview(otpFieldView)
        otpFieldView.initializeUI()

    }

    // MARK: - Button Actions

    /// Action for the Next button - navigates to NewPasswordViewController
    @IBAction func btnNextClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.StoryBoard.User, bundle: nil)
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
