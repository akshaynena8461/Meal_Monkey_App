import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btngooglelogin: UIButton!
    @IBOutlet weak var btnfacebooklogin: UIButton!
    @IBOutlet weak var btnforgotpassword: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        EditStyle.setborder(textfields: [txtEmail,txtPassword,btnlogin,btnfacebooklogin,btngooglelogin])
        EditStyle.setPadding(textFields: [txtEmail,txtPassword], paddingWidth: 34)
    }
    
    @IBAction func btnloginclick(_ sender: Any) {
        showMainTabBar()

    }
    @IBAction func btnforgotpasswordclick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
            if let signUpVC = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController {
                self.navigationController?.pushViewController(signUpVC, animated: true)
            }
    }
    @IBAction func btnfacebookloginclick(_ sender: Any) {
    }
    @IBAction func btngoogleloginclick(_ sender: Any) {
    }
    @IBAction func btnSignUpclick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "User", bundle: nil)
            if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
                self.navigationController?.pushViewController(signUpVC, animated: true)
            }
    }
    
    
    private func showMainTabBar() {
           let storyboard = UIStoryboard(name: "HomeStoryBoard", bundle: nil)
           if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController {

               if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate {

                   sceneDelegate.window?.rootViewController = tabBarController
                   sceneDelegate.window?.makeKeyAndVisible()
               }
           }
       }
}
