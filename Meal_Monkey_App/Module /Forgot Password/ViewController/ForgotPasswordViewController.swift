import UIKit

class ForgotPasswordViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var btnsend: UIButton!          // "Send" button
    @IBOutlet weak var txtemail: UITextField!      // Email input field
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style the text field and button
        EditStyle.setborder(textfields: [txtemail, btnsend], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtemail], paddingWidth: 34)
        
    }

    // MARK: - Actions
    @IBAction func btnsendclick(_ sender: Any) {
        // Navigate to OTP verification screen after clicking "Send"
        let storyboard = UIStoryboard(name: Main.StoryBoard.User, bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.OTP
        ) as? OTPViewController {
            self.navigationController?.pushViewController(
                signUpVC,
                animated: true
            )
        }
    }
}
