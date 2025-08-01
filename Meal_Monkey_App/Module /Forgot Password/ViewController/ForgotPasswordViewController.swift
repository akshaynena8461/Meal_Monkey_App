

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var btnsend: UIButton!
    @IBOutlet weak var txtemail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        EditStyle.setborder(textfields: [txtemail,btnsend])
        
        EditStyle.setPadding(textFields: [txtemail], paddingWidth: 34)
    }
    

    @IBAction func btnsendclick(_ sender: Any) {
    }
    

}
