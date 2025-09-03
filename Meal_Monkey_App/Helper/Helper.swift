import Foundation
import UIKit

extension UIViewController {

    /// ✅ Validates if the given password meets the required security rules.
    /// - Parameters:
    ///   - password: The password string entered by the user.
    /// - Returns: `true` if password is valid, otherwise `false`.
    ///
    /// Rules:
    /// - At least 1 uppercase letter
    /// - At least 1 lowercase letter
    /// - At least 1 digit
    /// - At least 1 special character
    /// - Minimum 8 characters long
    func isValidPassword(_ password: String) -> Bool {
        // Regex pattern for strong password validation
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        let passwordPredicate = NSPredicate(
            format: "SELF MATCHES %@",
            passwordRegex
        )
        return passwordPredicate.evaluate(with: password)
    }

    /// ✅ Validates if the given email is a valid Gmail address.
    /// - Parameters:
    ///   - email: The email string entered by the user.
    /// - Returns: `true` if email format is valid, otherwise `false`.
    ///
    /// Example of valid email:
    /// - `test123@gmail.com`
    func isValidEmail(_ email: String) -> Bool {
        // Regex that only accepts lowercase letters, numbers, and must end with `@gmail.com`
        let emailRegEx = #"^[a-z0-9]+@gmail.com$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }

    func isValidateMobileNumber(_ mobileNumber: String) -> Bool {
        if mobileNumber.count != 10
            || !CharacterSet.decimalDigits.isSuperset(
                of: CharacterSet(charactersIn: mobileNumber)
            )
        {
            return false
        }
        return true
    }

    /// ✅ Navigates the user to the Main Tab Bar after successful login or signup.
    ///
    /// - Loads `TabBarViewController` from **HomeStoryBoard**.
    /// - Sets it as the root view controller for the app’s window.
    /// - Makes sure the tab bar is visible and sets default tab to index `2`.
    func showMainTabBar() {
        // Load storyboard named "HomeStoryBoard"
        let storyboard = UIStoryboard(
            name: Main.StoryBoard.HomeStoryBoard,
            bundle: nil
        )

        // Instantiate TabBarViewController by identifier
        if let tabBarController = storyboard.instantiateViewController(
            withIdentifier: "TabBarViewController"
        ) as? TabBarViewController {

            // Access the current active window scene
            if let windowScene = UIApplication.shared.connectedScenes.first
                as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate
            {

                // Replace root VC with TabBarViewController
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()

                // Set the default selected tab (index 2)
                tabBarController.selectedIndex = 2
            }
        }
    }
}
