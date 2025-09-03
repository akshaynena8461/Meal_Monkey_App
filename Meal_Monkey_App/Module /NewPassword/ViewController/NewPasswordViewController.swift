import UIKit

class NewPasswordViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var stackConfirmPassword: UIStackView! // Stack for Confirm Password field
    @IBOutlet weak var btnNext: UIButton!                 // Next button to proceed
    @IBOutlet weak var stackPassword: UIStackView!       // Stack for Password field
    @IBOutlet weak var txtConfirmPassword: UITextField!  // Confirm Password TextField
    @IBOutlet weak var txtPassword: UITextField!         // Password TextField
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Apply rounded border to the Next button
        EditStyle.setborder(textfields: [btnNext], cornerRadious: 28)

        // Add borders to password stacks
        EditStyle.addStackBorder(stackViews: [stackPassword, stackConfirmPassword])
        
        // Add left padding to text fields
        EditStyle.setPadding(textFields: [txtPassword, txtConfirmPassword], paddingWidth: 34)
    }

    // MARK: - IBActions

    /// Action for Next button click
    /// Navigates to the ServiceViewController
    @IBAction func btnNextClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.StoryBoard.Services, bundle: nil)
        if let servicesVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.Service
        ) as? ServiceViewController {
            self.navigationController?.pushViewController(servicesVc, animated: true)
        }
    }
    
    /// Toggle Password visibility for txtPassword field
    @IBAction func btnEyeClick(_ sender: UIButton) {
        // Toggle secure text entry
        txtPassword.isSecureTextEntry.toggle()

        // Update eye icon based on visibility
        sender.setImage(
            UIImage(systemName: txtPassword.isSecureTextEntry ? "eye.slash" : "eye"),
            for: .normal
        )
    }
    
    /// Toggle Password visibility for txtConfirmPassword field
    @IBAction func btnEye2Click(_ sender: UIButton) {
        // Toggle secure text entry
        txtConfirmPassword.isSecureTextEntry.toggle()

        // Update eye icon based on visibility
        sender.setImage(
            UIImage(systemName: txtConfirmPassword.isSecureTextEntry ? "eye.slash" : "eye"),
            for: .normal
        )
    }
}
