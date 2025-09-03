import Foundation
import UIKit

// MARK: - UITextFieldDelegate Methods
extension LoginViewController: UITextFieldDelegate {

    // Called when the return key is pressed on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // If the current text field is the email field and the return key type is "Next"
        if textField == txtEmail  {
             // Dismiss keyboard from email field
            txtPassword.becomeFirstResponder() // Move focus to password field
        } else {
            // If it's the password field or any other text field
            txtPassword.resignFirstResponder() // Dismiss keyboard
        }
        return true // Allow default behavior of the return key
    }
}
