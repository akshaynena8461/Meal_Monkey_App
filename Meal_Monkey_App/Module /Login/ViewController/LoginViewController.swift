import CoreData
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var stackPassword: UIStackView!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btngooglelogin: UIButton!
    @IBOutlet weak var btnfacebooklogin: UIButton!
    @IBOutlet weak var btnforgotpassword: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var txtEmail: UITextField!

    var isPasswordVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        fetchAllUsers()
        EditStyle.setborder(
            textfields: [
                txtEmail, btnlogin, btnfacebooklogin, btngooglelogin,
            ],
            cornerRadious: 28
        )
        EditStyle.setPadding(
            textFields: [txtEmail, txtPassword],
            paddingWidth: 34
        )

        EditStyle.addStackBorder(stackViews: [stackPassword])
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func btnloginclick(_ sender: Any) {
        let email = txtEmail.text ?? ""
        let password = txtPassword.text ?? ""

        if email.isEmpty && password.isEmpty {
            UIAlertController.showAlert(
                title: "Missing Info",
                message: "Please enter your email and password.",
                viewController: self
            )
        }

        let context = app.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(
            format: "email == %@ AND password == %@",
            email,
            password
        )

        do {
            let users = try context.fetch(fetchRequest)
            if users.count > 0 {
                print("Login successful")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                UserDefaults.standard.set(email, forKey: "loggedInUserEmail")
                UserDefaults.standard.synchronize()

                showMainTabBar()
            } else {
                UIAlertController.showAlert(
                    title: "Error",
                    message: "Invalid Email or Password",
                    viewController: self
                )
            }
        }
        catch {
            print("Fetch failed: \(error.localizedDescription)")
            UIAlertController.showAlert(
                title: "Error",
                message: "Something went wrong.",
                viewController: self
            )
        }
    }
    @IBAction func btnforgotpasswordclick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(
            withIdentifier: "ForgotPasswordViewController"
        ) as? ForgotPasswordViewController {
            self.navigationController?.pushViewController(
                signUpVC,
                animated: true
            )
        }
    }

    @IBAction func btnfacebookloginclick(_ sender: Any) {
    }

    @IBAction func btngoogleloginclick(_ sender: Any) {
    }

    @IBAction func btnSignUpclick(_ sender: Any) {

        let storyboard = UIStoryboard(name: "User", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(
            withIdentifier: "SignUpViewController"
        ) as? SignUpViewController {
            self.navigationController?.pushViewController(
                signUpVC,
                animated: true
            )
        }
    }

    @IBAction func btnEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible

        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    func fetchAllUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")

        do {
            let users = try context.fetch(fetchRequest)

            if users.isEmpty {
                print(" No users found in Core Data.")
            } else {
                print(" Users found: \(users.count)")
                for (index, user) in users.enumerated() {
                    let username =
                        user.value(forKey: "name") as? String ?? "No Name"
                    let email =
                        user.value(forKey: "email") as? String ?? "No Email"
                    let address =
                        user.value(forKey: "address") as? String ?? "No Address"
                    let password =
                        user.value(forKey: "password") as? String
                        ?? "NO Password"
                    let mobile =
                        user.value(forKey: "mobileNumber") as? String
                        ?? "No MobileNumber"
                    print(
                        "User \(index + 1): \(username), \(email),\(password), \(address)",
                        "\(mobile)"
                    )
                }
            }
        }
        catch {
            print(" Failed to fetch users: \(error.localizedDescription)")
        }
    }

    func deleteAllUsers() {
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: "User"
        )
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                if let objData = object as? NSManagedObject {
                    context.delete(objData)
                }
            }
            try context.save()
            print("✅ All User records deleted")
        } catch {
            print("❌ Failed to delete: \(error.localizedDescription)")
        }
    }

}
