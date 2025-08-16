

import Foundation
import UIKit

extension UIViewController {
    
     func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
     func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[a-z0-9]+@gmail.com$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func showMainTabBar() {
        let storyboard = UIStoryboard(name: "HomeStoryBoard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(
            withIdentifier: "TabBarViewController"
        ) as? TabBarViewController {

            if let windowScene = UIApplication.shared.connectedScenes.first
                as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate
            {

                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
                tabBarController.selectedIndex = 2
            }
        }
    }
}
