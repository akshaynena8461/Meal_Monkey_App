import CoreData
import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var stackDetail: UIStackView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!

    var loggedInUser: NSManagedObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        fetUserData()

        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
        imgProfile.layer.masksToBounds = true
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.borderColor = UIColor.systemGray.cgColor

        let imageGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(addImage)
        )

        imgProfile.addGestureRecognizer(imageGesture)
        setLeftAlignedTitle("Profile")
        setCartButton(target: self, action: #selector(cartBtnTapped))

        EditStyle.setborder(
            textfields: [txtName, txtEmail, txtMobile, txtAddress, btnSave],
            cornerRadious: 28
        )

        EditStyle.setPadding(
            textFields: [txtName, txtEmail, txtMobile, txtAddress],
            paddingWidth: 34
        )
    }

    @objc func addImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }

    @objc func cartBtnTapped() {
        print("Cart Btn Tapped")
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                cartVc,
                animated: true
            )
        }
    }

    @IBAction func btnEditProfileClick(_ sender: Any) {
    }

    @IBAction func btnSignOutClick(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        if let signOutVc = storyboard.instantiateViewController(
            withIdentifier: "LoginViewController"
        ) as? LoginViewController {
            self.navigationController?.pushViewController(
                signOutVc,
                animated: true
            )
        }
    }

    func fetUserData() {
        let context = app.persistentContainer.viewContext

        guard
            let loggedInEmail = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            )
        else {
            print("⚠️ No logged in user found")
            return
        }

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(
            format: "email == %@",
            loggedInEmail
        )

        do {
            let users = try context.fetch(fetchRequest)
            if let currentUser = users.first as? User {
                txtName.text = currentUser.name
                txtEmail.text = currentUser.email
                txtAddress.text = currentUser.address
                txtMobile.text = currentUser.mobileNumber
                lblUserName.text = "\(currentUser.name ?? "Alise")!"
            }
        } catch {
            print("Failed To fetch User: \(error)")
        }
    }

    @IBAction func btnSaveClick(_ sender: Any) {
        let context = app.persistentContainer.viewContext

        guard
            let loggedInEmail = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            )
        else {
            print("⚠️ No logged in user found")
            return
        }

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(
            format: "email == %@",
            loggedInEmail
        )

        do {
            let results = try context.fetch(fetchRequest)
            if let user = results.first {
                user.setValue(txtName.text, forKey: "name")
                user.setValue(txtEmail.text, forKey: "email")
                user.setValue(txtMobile.text, forKey: "mobileNumber")
                user.setValue(txtAddress.text ?? "", forKey: "address")

                try context.save()
                UIAlertController.showAlert(
                    title: "Success",
                    message: "Profile Updated",
                    viewController: self
                )
            } else {
                print("No logged-in user found")
            }
        } catch {
            print("Failed to update user: \(error)")
        }
    }

}
