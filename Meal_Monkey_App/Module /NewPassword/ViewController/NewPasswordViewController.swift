import UIKit

class NewPasswordViewController: UIViewController {

    @IBOutlet weak var stackConfirmPassword: UIStackView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var stackPassword: UIStackView!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        EditStyle.setborder(
            textfields: [btnNext],
            cornerRadious: 28
        )
        EditStyle.addStackBorder(stackViews: [stackPassword,stackConfirmPassword])
        
        EditStyle.setPadding(
            textFields: [txtPassword, txtConfirmPassword],
            paddingWidth: 34
        )
    }

    @IBAction func btnNextClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Services", bundle: nil)
        if let servicesVc = storyboard.instantiateViewController(
            withIdentifier: "ServiceViewController"
        ) as? ServiceViewController {
            self.navigationController?.pushViewController(
                servicesVc,
                animated: true
            )
        }
    }
    
    @IBAction func btnEyeClick(_ sender: UIButton) {
        txtPassword.isSecureTextEntry.toggle()
        sender.setImage(
            UIImage(
                systemName: txtPassword.isSecureTextEntry ? "eye.slash" : "eye"
            ),
            for: .normal
        )
    }
    
    @IBAction func btnEye2Click(_ sender: UIButton) {
        txtConfirmPassword.isSecureTextEntry.toggle()
        sender.setImage(
            UIImage(
                systemName: txtConfirmPassword.isSecureTextEntry ? "eye.slash" : "eye"
            ),
            for: .normal
        )
    }
}
