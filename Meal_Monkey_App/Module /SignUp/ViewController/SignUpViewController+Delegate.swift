import Foundation
import UIKit

// Extend SignUpViewController to conform to UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    /// Handles "Return" key actions for text fields
    /// - Parameter textField: The text field where the "Return" key was pressed
    /// - Returns: Bool indicating whether the text field should process the return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // When user presses "Return" on Name field → move focus to Email
        if textField == txtName {
            txtEmail.becomeFirstResponder()
            
        // When user presses "Return" on Email field → move focus to Mobile
        } else if textField == txtEmail {
            txtMobile.becomeFirstResponder()
            
        // When user presses "Return" on Mobile field → move focus to Address
        } else if textField == txtMobile {
            txtAddress.becomeFirstResponder()
            
        // When user presses "Return" on Address field → move focus to Password
        } else if textField == txtAddress {
            txtPassword.becomeFirstResponder()
            
        // When user presses "Return" on Password field → move focus to Confirm Password
        } else if textField == txtPassword {
            txtConfirmPassword.becomeFirstResponder()
            
        // When user presses "Return" on Confirm Password field → dismiss keyboard
        } else if textField == txtConfirmPassword {
            txtConfirmPassword.resignFirstResponder()  // closes keyboard
        }
        
        return true
    }
}
