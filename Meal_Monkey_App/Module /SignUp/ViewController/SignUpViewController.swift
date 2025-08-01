

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        EditStyle.setborder(textfields: [txtName,txtEmail,txtMobile,txtAddress,txtName,txtPassword,txtConfirmPassword,btnSignUp])
        
        EditStyle.setPadding(textFields: [txtName,txtEmail,txtMobile,txtAddress,txtPassword,txtConfirmPassword], paddingWidth: 34)

    }
    
    @IBAction func btnloginclick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func btnSignUpclick(_ sender: Any) {
    }
}
