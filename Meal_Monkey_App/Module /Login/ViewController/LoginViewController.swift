import CoreData
import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var stackPassword: UIStackView! // Stack containing password field and eye button
    @IBOutlet weak var btnEye: UIButton! // Button to toggle password visibility
    @IBOutlet weak var btnSignUp: UIButton! // Navigate to SignUp screen
    @IBOutlet weak var btngooglelogin: UIButton! // Google login button
    @IBOutlet weak var btnfacebooklogin: UIButton! // Facebook login button
    @IBOutlet weak var btnforgotpassword: UIButton! // Navigate to Forgot Password screen
    @IBOutlet weak var txtPassword: UITextField! // Password input
    @IBOutlet weak var btnlogin: UIButton! // Login button
    @IBOutlet weak var txtEmail: UITextField! // Email input

    // MARK: - Variables
    var isPasswordVisible = false // Tracks password visibility

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        viewScroll.showsVerticalScrollIndicator = false

        // Fetch all existing users from Core Data (for debug/log purposes)
        fetchAllUsers()

        // UI Styling
        EditStyle.setborder(
            textfields: [txtEmail, btnlogin, btnfacebooklogin, btngooglelogin],
            cornerRadious: 28
        )
        EditStyle.setPadding(
            textFields: [txtEmail, txtPassword],
            paddingWidth: 34
        )
        EditStyle.addStackBorder(stackViews: [stackPassword])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide tab bar on login screen
        self.tabBarController?.tabBar.isHidden = true
    }

    // MARK: - Login Button Action
    @IBAction func btnloginclick(_ sender: Any) {
        let email = txtEmail.text ?? ""
        let password = txtPassword.text ?? ""

        // Check if email and password are provided
        if email.isEmpty && password.isEmpty {
            UIAlertController.showAlert(
                title: Main.Alert.emptyFieldsTitle,
                message: Main.Alert.fieldsToFillMsg,
                viewController: self
            )
            return
        }

        let context = app.persistentContainer.viewContext

        // Fetch User entity with matching email and password
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(
            format: "email == %@ AND password == %@",
            email,
            password
        )

        do {
            let users = try context.fetch(fetchRequest)
            if users.count > 0 {
                // Successful login
                print("Login successful")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(email, forKey: "loggedInUserEmail")
                UserDefaults.standard.synchronize()

                // Show main app screen (tab bar controller)
                showMainTabBar()
            } else {
                // Invalid credentials
                UIAlertController.showAlert(
                    title: "Error",
                    message: Main.Alert.invalidCredentialmsg,
                    viewController: self
                )
            }
        } catch {
            // Fetch error
            print("Fetch failed: \(error.localizedDescription)")
            UIAlertController.showAlert(
                title: Main.Alert.errorTitle,
                message: Main.Alert.fetchFailedMsg,
                viewController: self
            )
        }
    }

    // MARK: - Forgot Password Button
    @IBAction func btnforgotpasswordclick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.StoryBoard.User, bundle: nil)
        if let forgotPasswordVC = storyboard.instantiateViewController(
            withIdentifier: "ForgotPasswordViewController"
        ) as? ForgotPasswordViewController {
            self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
        }
    }

    // MARK: - Facebook Login Button
    @IBAction func btnfacebookloginclick(_ sender: Any) {
        // Handle Facebook login (currently empty)
    }

    // MARK: - Google Login Button
    @IBAction func btngoogleloginclick(_ sender: Any) {
        // Handle Google login (currently empty)
    }

    // MARK: - SignUp Button
    @IBAction func btnSignUpclick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.StoryBoard.User, bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(
            withIdentifier: "SignUpViewController"
        ) as? SignUpViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }

    // MARK: - Eye Button to Show/Hide Password
    @IBAction func btnEyeClick(_ sender: Any) {
        // Toggle password visibility
        isPasswordVisible.toggle()
        txtPassword.isSecureTextEntry = !isPasswordVisible

        // Update button image
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    // MARK: - Fetch All Users (Debugging/Logging)
    func fetchAllUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")

        do {
            let users = try context.fetch(fetchRequest)

            if users.isEmpty {
                print("No users found in Core Data.")
            } else {
                print("Users found: \(users.count)")
                for (index, user) in users.enumerated() {
                    let username = user.value(forKey: "name") as? String ?? "No Name"
                    let email = user.value(forKey: "email") as? String ?? "No Email"
                    let address = user.value(forKey: "address") as? String ?? "No Address"
                    let password = user.value(forKey: "password") as? String ?? "No Password"
                    let mobile = user.value(forKey: "mobileNumber") as? String ?? "No MobileNumber"

                    print(
                        "User \(index + 1): \(username), \(email), \(password), \(address), \(mobile)"
                    )
                }
            }
        } catch {
            print("Failed to fetch users: \(error.localizedDescription)")
        }
    }
}
