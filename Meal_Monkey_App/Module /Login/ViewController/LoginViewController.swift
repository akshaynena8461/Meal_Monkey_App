import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var stackPassword: UIStackView!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btngooglelogin: UIButton!
    @IBOutlet weak var btnfacebooklogin: UIButton!
    @IBOutlet weak var btnforgotpassword: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var txtEmail: UITextField!

    var isPasswordVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        EditStyle.setborder(
            textfields: [
                txtEmail, btnlogin, btnfacebooklogin, btngooglelogin,
            ],
            cornerRadious: 28
        )
        EditStyle.setPadding(
            textFields: [txtEmail, txtPassword],
            paddingWidth: 34
        )

        EditStyle.addStackBorder(stackViews: [stackPassword])

    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnloginclick(_ sender: Any) {
        showMainTabBar()
    }
    @IBAction func btnforgotpasswordclick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(
            withIdentifier: "ForgotPasswordViewController"
        ) as? ForgotPasswordViewController {
            self.navigationController?.pushViewController(
                signUpVC,
                animated: true
            )
        }
    }

    @IBAction func btnfacebookloginclick(_ sender: Any) {
    }

    @IBAction func btngoogleloginclick(_ sender: Any) {
    }

    @IBAction func btnSignUpclick(_ sender: Any) {

        let storyboard = UIStoryboard(name: "User", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(
            withIdentifier: "SignUpViewController"
        ) as? SignUpViewController {
            self.navigationController?.pushViewController(
                signUpVC,
                animated: true
            )
        }
    }

    @IBAction func btnEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible

        let imageName = isPasswordVisible ? "eye": "eye.slash"

        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: "HomeStoryBoard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(
            withIdentifier: "TabBarViewController"
        ) as? TabBarViewController {

            if let windowScene = UIApplication.shared.connectedScenes.first
                as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate
            {

                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
                tabBarController.selectedIndex = 2
            }
        }
    }
}
