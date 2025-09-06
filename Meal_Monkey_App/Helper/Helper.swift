import Foundation
import Lottie
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

    func setEmptyBackgroundViewWithLottie(
        tableView: UITableView,
        animationName: String,
        message: String
    ) {
        let backgroundView = UIView(frame: self.view.bounds)

        // Lottie Animation View
        let animationView = LottieAnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false

        // Label
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        backgroundView.addSubview(animationView)
        backgroundView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor
            ),
            animationView.centerYAnchor.constraint(
                equalTo: backgroundView.centerYAnchor,
                constant: -40
            ),
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.heightAnchor.constraint(equalToConstant: 200),

            messageLabel.topAnchor.constraint(
                equalTo: animationView.bottomAnchor,
                constant: 16
            ),
            messageLabel.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor
            ),
        ])
        tableView.backgroundView = backgroundView
    }
}

extension UIButton {
    func setLocalizedPartialHighlight(fullKey: String,
                                      highlightKey: String,
                                      highlightColor: UIColor = .systemOrange,
                                      fontSize: CGFloat = 14) {
        // Get localized full text
        let fullText = LanguageManager.shared.localizedString(for: fullKey) as NSString
        // Get localized highlight part
        let highlightText = LanguageManager.shared.localizedString(for: highlightKey)
        
        // Base attributed string
        let attributedString = NSMutableAttributedString(
            string: fullText as String,
            attributes: [
                .font: UIFont.systemFont(ofSize: fontSize),
                .foregroundColor: UIColor.darkGray
            ]
        )
        
        // Find range of highlight
        let range = fullText.range(of: highlightText)
        if range.location != NSNotFound {
            attributedString.addAttributes([
                .font: UIFont.boldSystemFont(ofSize: fontSize),
                .foregroundColor: highlightColor
            ], range: range)
        }
        
        // Set button title
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
