import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sleep(2)

        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            showMainTabBar()
        }
        else {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            if let vc = storyboard.instantiateViewController(
                withIdentifier: "LoginViewController"
            ) as? LoginViewController {
                self.navigationController?.pushViewController(
                    vc,
                    animated: true
                )
            }
        }
    }
}
