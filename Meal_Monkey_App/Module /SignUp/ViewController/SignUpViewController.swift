import CoreData
import UIKit

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnlogin: UIButton!

    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var btnEye1: UIButton!  // Toggle password visibility for txtPassword
    @IBOutlet weak var btnEye2: UIButton!  // Toggle password visibility for txtConfirmPassword
    @IBOutlet weak var stackPassword: UIStackView!
    @IBOutlet weak var stackConfirmPassword: UIStackView!

    // MARK: - Variables
    var isPasswordVisible: Bool = false  // Tracks password visibility state

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewScroll.showsVerticalScrollIndicator = false
        // Apply rounded borders to text fields and buttons
        EditStyle.setborder(
            textfields: [
                txtName, txtEmail, txtMobile, txtAddress, txtName, btnSignUp,
            ],
            cornerRadious: 28
        )

        // Add padding inside text fields
        EditStyle.setPadding(
            textFields: [
                txtName, txtEmail, txtMobile, txtAddress, txtPassword,
                txtConfirmPassword,
            ],
            paddingWidth: 34
        )

        // Add border style to password stacks
        EditStyle.addStackBorder(stackViews: [
            stackPassword, stackConfirmPassword,
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyLocalization()
    }

    func applyLocalization() {
        lblSignUp.text = LanguageManager.shared.localizedString(
            for: "8461_signup_title"
        )
        lblSubtitle.text = LanguageManager.shared.localizedString(
            for: "8461_signup_subtitle"
        )

        txtName.placeholder = LanguageManager.shared.localizedString(
            for: "8461_name_placeholder"
        )
        txtEmail.placeholder = LanguageManager.shared.localizedString(
            for: "8461_email_placeholder"
        )
        txtMobile.placeholder = LanguageManager.shared.localizedString(
            for: "8461_mobile_placeholder"
        )
        txtAddress.placeholder = LanguageManager.shared.localizedString(
            for: "8461_address_placeholder"
        )
        txtPassword.placeholder = LanguageManager.shared.localizedString(
            for: "8461_password_placeholder"
        )
        txtConfirmPassword.placeholder = LanguageManager.shared.localizedString(
            for: "8461_confirm_password_placeholder"
        )

        btnSignUp.setTitle(
            LanguageManager.shared.localizedString(for: "8461_signup_button"),
            for: .normal
        )

        btnlogin.setLocalizedPartialHighlight(
            fullKey: "8461_login_button_full",
            highlightKey: "8461_login_button_highlight",
            highlightColor: UIColor(named: "loginbtnbg")!
        )
    }

    // MARK: - Password Visibility Toggle
    @IBAction func btnEye1Click(_ sender: Any) {
        // Toggle password visibility
        isPasswordVisible.toggle()
        txtPassword.isSecureTextEntry = !isPasswordVisible

        // Update button image
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    @IBAction func btnEye2Click(_ sender: Any) {
        isPasswordVisible.toggle()
        txtConfirmPassword.isSecureTextEntry = !isPasswordVisible

        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    // MARK: - Navigation
    @IBAction func btnloginclick(_ sender: Any) {
        // Go back to login screen
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Sign Up Action
    @IBAction func btnSignUpclick(_ sender: Any) {
        // Retrieve user input
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        let mobile = txtMobile.text ?? ""
        let address = txtAddress.text ?? ""
        let password = txtPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""

        // Validation: Check for empty fields
        if name.isEmpty && email.isEmpty && mobile.isEmpty && address.isEmpty
            && password.isEmpty && confirmPassword.isEmpty
        {
            UIAlertController.showAlert(
                title: Main.Alert.emptyFieldsTitle,
                message: Main.Alert.fieldsToFillMsg,
                viewController: self
            )
            return
        }

        // Validation: Individual fields
        if name.isEmpty {
            UIAlertController.showAlert(
                title: Main.Alert.nameMissingTitle,
                message: Main.Alert.nameMissingMsg,
                viewController: self
            )
            return
        }

        if email.isEmpty {
            UIAlertController.showAlert(
                title: Main.Alert.emailexistingTitle,
                message: Main.Alert.emailMissingMsg,
                viewController: self
            )
            return
        }

        if !isValidEmail(email) {
            UIAlertController.showAlert(
                title: Main.Alert.invalidEmailTitle,
                message: Main.Alert.invalidEmailMsg,
                viewController: self
            )
            return
        }

        if mobile.isEmpty {
            UIAlertController.showAlert(
                title: Main.Alert.mobileMissingTitle,
                message: Main.Alert.mobileMissingMsg,
                viewController: self
            )
            return
        }

        if !isValidateMobileNumber(mobile) {
            UIAlertController.showAlert(
                title: Main.Alert.errorTitle,
                message: Main.Alert.invalidMobile,
                viewController: self
            )
            return
        }

        if address.isEmpty {
            UIAlertController.showAlert(
                title: Main.Alert.adddressMissingTitle,
                message: Main.Alert.addressMissingMsg,
                viewController: self
            )
            return
        }

        if password.isEmpty {
            UIAlertController.showAlert(
                title: Main.Alert.passwordMissingTitle,
                message: Main.Alert.passwordMissinMsg,
                viewController: self
            )
            return
        }

        if !isValidPassword(password) {
            UIAlertController.showAlert(
                title: Main.Alert.invalidPasswordTitle,
                message: Main.Alert.invalidPasswordMsg,
                viewController: self
            )
            return
        }

        if password != confirmPassword {
            UIAlertController.showAlert(
                title: Main.Alert.notMatchPasswordTitle,
                message: Main.Alert.notMatchPasswordMsg,
                viewController: self
            )
            return
        }

        // MARK: - Core Data Save
        let context = app.persistentContainer.viewContext

        // Check if email already exists
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: "User"
        )
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                UIAlertController.showAlert(
                    title: Main.Alert.emailexistingTitle,
                    message: Main.Alert.emailexistinMsg,
                    viewController: self
                )
                return
            }
        } catch {
            print("Error checking existing email: \(error)")
        }

        // Insert new user
        let user = NSEntityDescription.insertNewObject(
            forEntityName: "User",
            into: context
        )
        user.setValue(name, forKey: "name")
        user.setValue(email, forKey: "email")
        user.setValue(mobile, forKey: "mobileNumber")
        user.setValue(password, forKey: "password")
        user.setValue(address, forKey: "address")

        do {
            try context.save()
            let alert = UIAlertController(
                title: Main.Alert.successTitle,
                message: Main.Alert.userRegisterSuccessMsg,
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(title: LanguageManager.shared.localizedString(for: "8461_Alert_ok"), style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            )
            present(alert, animated: true)

        } catch {
            print("Failed to save user: \(error.localizedDescription)")
            let alert = UIAlertController(
                title: Main.Alert.errorTitle,
                message: Main.Alert.fetchFailedMsg,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: LanguageManager.shared.localizedString(for: "8461_Alert_ok"), style: .default))
            present(alert, animated: true)
        }
    }
}
