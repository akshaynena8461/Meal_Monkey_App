import Foundation
import UIKit

extension UIAlertController {
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

        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: { _ in

                }
            )
        )
        viewController.present(alert, animated: true)
    }

    class func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        let passwordPredicate = NSPredicate(
            format: "SELF MATCHES %@",
            passwordRegex
        )
        return passwordPredicate.evaluate(with: password)
    }

    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[a-z0-9]+@gmail.com$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
