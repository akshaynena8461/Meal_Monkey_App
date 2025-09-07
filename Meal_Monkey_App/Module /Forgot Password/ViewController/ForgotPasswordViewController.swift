import UIKit

class ForgotPasswordViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnsend: UIButton!  // "Send" button
    @IBOutlet weak var txtemail: UITextField!  // Email input field

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Style the text field and button
        EditStyle.setborder(textfields: [txtemail, btnsend], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtemail], paddingWidth: 34)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyLocalization()
        applyAccentTheme() 
    }

    func applyLocalization() {
        lblTitle.text = LanguageManager.shared.localizedString(
            for: "8461_forgot_title"
        )
        lblSubTitle.text = LanguageManager.shared.localizedString(
            for: "8461_forgot_subtitle"
        )

        txtemail.placeholder = LanguageManager.shared.localizedString(
            for: "8461_forgot_email_placeholder"
        )

        btnsend.setTitle(
            LanguageManager.shared.localizedString(
                for: "8461_forgot_send_button"
            ),
            for: .normal
        )
    }
    
    func applyAccentTheme() {
        let theme = ThemeManager.shared

        view.backgroundColor = theme.backgroundColor()
        mainView.backgroundColor = theme.backgroundColor()

        // Labels
        lblTitle.textColor = theme.textColor()
        lblSubTitle.textColor = theme.subTextColor()

        // TextFields
        txtemail.textColor = theme.textColor()
        btnsend.setTitleShadowColor(.white, for: .normal)
        btnsend.backgroundColor = theme.primaryButtonBackground()
      
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
