import Foundation
import UIKit

extension UIAlertController {
    
    /// ✅ Shows a simple alert with "Ok" button.
    /// - Parameters:
    ///   - title: Title of the alert.
    ///   - message: Message to display inside the alert.
    ///   - viewController: The view controller where alert will be presented.
    class func showAlert(
        title: String,
        message: String,
        viewController: UIViewController
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        // Default "Ok" button
        alert.addAction(
            UIAlertAction(title: "Ok", style: .default, handler: nil)
        )
        
        viewController.present(alert, animated: true)
    }
    
    
    /// ✅ Validates if the given password meets strong security rules.
    /// - Parameter password: The password string entered by the user.
    /// - Returns: `true` if password is valid, otherwise `false`.
    ///
    /// Rules:
    /// - At least 1 uppercase letter
    /// - At least 1 lowercase letter
    /// - At least 1 digit
    /// - At least 1 special character
    /// - Minimum length: 8 characters
    class func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    
    /// ✅ Validates if the email is a proper Gmail address.
    /// - Parameter email: The email string entered by the user.
    /// - Returns: `true` if the email format is valid, otherwise `false`.
    ///
    /// Example of valid email: `user123@gmail.com`
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[a-z0-9]+@gmail.com$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
