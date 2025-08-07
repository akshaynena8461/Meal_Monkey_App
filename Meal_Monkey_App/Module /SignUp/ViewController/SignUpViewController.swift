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
        EditStyle.setborder(textfields: [
            txtName,
            txtEmail,
            txtMobile,
            txtAddress,
            txtName,
            btnSignUp,
        ],cornerRadious: 28)

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
        
        EditStyle.addStackBorder(stackViews: [stackPassword,stackConfirmPassword])

    }

    @IBAction func btnloginclick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSignUpclick(_ sender: Any) {

    }
}
