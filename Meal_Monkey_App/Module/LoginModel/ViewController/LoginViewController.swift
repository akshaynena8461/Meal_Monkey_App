import UIKit

class LoginViewController: UIViewController, UIPointerInteractionDelegate {
    
    @IBOutlet weak var btnforgot: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var btnregister: UIButton!
    @IBOutlet weak var imgview: UIImageView!
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        self.title = "Log in"
        super.viewDidLoad()
    }

}
