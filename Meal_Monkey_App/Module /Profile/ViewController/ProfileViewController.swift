import CoreData
import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var profileScrollView: UIScrollView!
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

    // MARK: - Variables
    var loggedInUser: NSManagedObject?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch and display user data
        fetUserData()

        // Set up profile image appearance
        profileScrollView.showsVerticalScrollIndicator = false
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
        imgProfile.layer.masksToBounds = true
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.borderColor = UIColor.systemGray.cgColor

        // Add tap gesture to profile image for image selection
        let imageGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(addImage)
        )
        imgProfile.addGestureRecognizer(imageGesture)

        // Set navigation title and cart button
        setLeftAlignedTitle("Profile")
        setCartButton(target: self, action: #selector(cartBtnTapped))

        // Apply borders and corner radius to text fields and buttons
        EditStyle.setborder(
            textfields: [txtName, txtEmail, txtMobile, txtAddress, btnSave],
            cornerRadious: 28
        )

        // Add left padding to text fields
        EditStyle.setPadding(
            textFields: [txtName, txtEmail, txtMobile, txtAddress],
            paddingWidth: 34
        )
    }

    // MARK: - Image Picker
    @objc func addImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }

    // MARK: - Cart Button Action
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

    // MARK: - Edit Profile Action
    @IBAction func btnEditProfileClick(_ sender: Any) {
        // TODO: Implement edit profile logic if needed
    }

    // MARK: - Sign Out Action
    @IBAction func btnSignOutClick(_ sender: Any) {
        // Remove login status from UserDefaults
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")

        // Navigate to Login screen
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

    // MARK: - Fetch User Data
    func fetUserData() {
        let context = app.persistentContainer.viewContext

        // Get the logged-in user's email from UserDefaults
        guard
            let loggedInEmail = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            )
        else {
            print("⚠️ No logged in user found")
            return
        }

        // Fetch the User entity from Core Data matching the email
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(
            format: "email == %@",
            loggedInEmail
        )

        do {
            let users = try context.fetch(fetchRequest)
            if let currentUser = users.first as? User {
                // Populate UI fields with user data
                txtName.text = currentUser.name
                txtEmail.text = currentUser.email
                txtAddress.text = currentUser.address
                txtMobile.text = currentUser.mobileNumber
                lblUserName.text = "\(currentUser.name ?? "Alise")!"

                if let imageData = currentUser.userImage {
                    imgProfile.image = UIImage(data: imageData)
                } else {
                    imgProfile.image = UIImage(named: "placeholder_profile")  // fallback image
                }
            }
        } catch {
            print("Failed To fetch User: \(error)")
        }
    }

    // MARK: - Save Profile Action
    @IBAction func btnSaveClick(_ sender: Any) {
        let context = app.persistentContainer.viewContext

        // Get the logged-in user's email
        guard
            let loggedInEmail = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            )
        else {
            print("⚠️ No logged in user found")
            return
        }

        // Fetch the user from Core Data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(
            format: "email == %@",
            loggedInEmail
        )

        do {
            let results = try context.fetch(fetchRequest)
            if let user = results.first {
                // Update user data with new values
                user.setValue(txtName.text, forKey: "name")
                user.setValue(txtEmail.text, forKey: "email")
                user.setValue(txtMobile.text, forKey: "mobileNumber")
                user.setValue(txtAddress.text ?? "", forKey: "address")

                if let newImage = imgProfile.image,  // e.g. from UIImageView
                    let imageData = newImage.jpegData(compressionQuality: 0.8)
                {
                    user.setValue(imageData, forKey: "userImage")
                }

                // Save changes to Core Data
                try context.save()

                // Show success alert
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
