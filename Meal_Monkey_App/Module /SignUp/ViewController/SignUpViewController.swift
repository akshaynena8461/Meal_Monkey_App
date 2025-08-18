import CoreData
import UIKit

class SignUpViewController: UIViewController {

    var isPasswordVisible: Bool = false
    @IBOutlet weak var btnEye1: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!

    @IBOutlet weak var stackConfirmPassword: UIStackView!
    @IBOutlet weak var stackPassword: UIStackView!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtMobile: UITextField!

    @IBOutlet weak var btnEye2: UIButton!
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!

    @IBAction func btnEye1Click(_ sender: Any) {
        isPasswordVisible.toggle()
        txtPassword.isSecureTextEntry = !isPasswordVisible

        let imageName = isPasswordVisible ? "eye" : "eye.slash"

        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    @IBAction func btnEye2Click(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtConfirmPassword.isSecureTextEntry = !isPasswordVisible

        let imageName = isPasswordVisible ? "eye" : "eye.slash"

        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        EditStyle.setborder(
            textfields: [
                txtName,
                txtEmail,
                txtMobile,
                txtAddress,
                txtName,
                btnSignUp,
            ],
            cornerRadious: 28
        )

        EditStyle.setPadding(
            textFields: [
                txtName,
                txtEmail,
                txtMobile,
                txtAddress,
                txtPassword,
                txtConfirmPassword,
            ],
            paddingWidth: 34
        )

        EditStyle.addStackBorder(stackViews: [
            stackPassword, stackConfirmPassword,
        ])

    }

    @IBAction func btnloginclick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSignUpclick(_ sender: Any) {
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        let mobile = txtMobile.text ?? ""
        let address = txtAddress.text ?? ""
        let password = txtPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""

        if name.isEmpty && email.isEmpty && mobile.isEmpty && address.isEmpty
            && password.isEmpty && confirmPassword.isEmpty
        {
            UIAlertController.showAlert(
                title: "Missing Info",
                message: "Please fill all required fields!",
                viewController: self
            )
            return
        }

        if name.isEmpty {
            UIAlertController.showAlert(
                title: "Name Missing",
                message: "Please Enter Your Name",
                viewController: self
            )
            return
        }

        if email.isEmpty {
            UIAlertController.showAlert(
                title: "Email Missing",
                message: "Please Enter Your Email",
                viewController: self
            )
            return
        }
        if !isValidEmail(email) {
            UIAlertController.showAlert(
                title: "Invalid Email",
                message: "Please enter a valid email address.",
                viewController: self
            )
            return
        }

        if mobile.isEmpty {
            UIAlertController.showAlert(
                title: "Mobile Number Missing",
                message: "Please enter Your Mobile Number",
                viewController: self
            )
            return
        }

        if address.isEmpty {
            UIAlertController.showAlert(
                title: "Address Missing",
                message: "Please enter Your Address",
                viewController: self
            )
            return
        }
        if password.isEmpty {
            UIAlertController.showAlert(
                title: "Password Missing",
                message: "Please Set Your Password",
                viewController: self
            )
            return
        }

        if !isValidPassword(password) {
            UIAlertController.showAlert(
                title: "Invalid Password",
                message:
                    "Password must be at least 8 characters, contain uppercase, lowercase, number, and symbol.",
                viewController: self
            )
            return
        }

        if password != confirmPassword {
            UIAlertController.showAlert(
                title: "Passwords Don't Match",
                message: "Password and Confirm Password must be the same.",
                viewController: self
            )
            return
        }

        let context = app.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: "User"
        )
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                UIAlertController.showAlert(
                    title: "Email Exists",
                    message: "This email is already registered.",
                    viewController: self
                )
                return
            }
        } catch {
            print(" Error checking existing email: \(error)")
        }

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
            print("User registered successfully.")
            UIAlertController.showAlert(
                title: "Success",
                message: "User Saved Successfully",
                viewController: self
            )
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
            UIAlertController.showAlert(
                title: "Error",
                message: "Something went wrong while saving.",
                viewController: self
            )
        }
    }
}
