import UIKit

class SplashViewController: UIViewController {

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Called after the view has been loaded.
        // Perform any additional setup here if needed.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Called after the view is added to the app’s view hierarchy
        
        // Pause the splash screen for 2 seconds
        // ⚠️ Note: Using sleep blocks the main thread and freezes the UI
        sleep(2)

        // Check if the user is logged in
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            // User is logged in, navigate to the main tab bar
            showMainTabBar()
        }
        else {
            // User is not logged in, navigate to the Login screen
            let storyboard = UIStoryboard(name:Main.StoryBoard.User, bundle: nil)
            if let vc = storyboard.instantiateViewController(
                withIdentifier: Main.ViewControllers.Login
            ) as? LoginViewController {
                // Push LoginViewController onto the navigation stack
                self.navigationController?.pushViewController(
                    vc,
                    animated: true
                )
            }
        }
    }
}
