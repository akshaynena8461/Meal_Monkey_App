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
                    imgProfile.image = UIImage(systemName: "person.fill")
                }
            }
        } catch {
            print("Failed To fetch User: \(error)")
        }
    }

    // MARK: - Save Profile Action
    @IBAction func btnSaveClick(_ sender: Any) {
        let context = app.persistentContainer.viewContext

        // 1️⃣ Get logged-in email from UserDefaults
        guard
            let loggedInEmail = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            )
        else {
            print("❌ No logged-in user found in UserDefaults")
            return
        }
        print("ℹ️ Logged in user email from UserDefaults: \(loggedInEmail)")

        // 2️⃣ Check for duplicate email (if changed)
        if let newEmail = txtEmail.text, !newEmail.isEmpty,
            newEmail != loggedInEmail
        {
            let emailCheckRequest = NSFetchRequest<NSFetchRequestResult>(
                entityName: "User"
            )
            emailCheckRequest.predicate = NSPredicate(
                format: "email == %@",
                newEmail
            )

            do {
                let existingUsers = try context.fetch(emailCheckRequest)
                if !existingUsers.isEmpty {
                    print("❌ Duplicate email found: \(newEmail)")
                    UIAlertController.showAlert(
                        title: "Email Exists",
                        message: "This email is already registered.",
                        viewController: self
                    )
                    return
                }
            } catch {
                print("❌ Error checking existing email: \(error)")
            }
        }

        // 3️⃣ Fetch the logged-in user
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(
            format: "email == %@",
            loggedInEmail
        )

        do {
            let results = try context.fetch(fetchRequest)
            print("ℹ️ Fetch results count: \(results.count)")

            if let user = results.first {
                print("✅ Found user: \(user)")

                // 4️⃣ Update user data safely
                if let name = txtName.text, !name.isEmpty {
                    user.setValue(name, forKey: "name")
                }
                if let email = txtEmail.text, !email.isEmpty {
                    user.setValue(email, forKey: "email")
                }
                if let mobile = txtMobile.text, !mobile.isEmpty {
                    user.setValue(mobile, forKey: "mobileNumber")
                }
                if let address = txtAddress.text, !address.isEmpty {
                    user.setValue(address, forKey: "address")
                }

                // 5️⃣ Update profile image if available
                if let newImage = imgProfile.image,
                    let imageData = newImage.jpegData(compressionQuality: 0.8)
                {
                    user.setValue(imageData, forKey: "userImage")
                    print("📸 Profile image updated")
                }

                // 6️⃣ Save to Core Data
                try context.save()
                print("💾 User saved successfully")

                // 7️⃣ Update UserDefaults if email changed
                if let updatedEmail = txtEmail.text, !updatedEmail.isEmpty {
                    UserDefaults.standard.set(
                        updatedEmail,
                        forKey: "loggedInUserEmail"
                    )
                    print(
                        "🔄 UserDefaults updated with new email: \(updatedEmail)"
                    )
                }

                // 8️⃣ Show success alert
                UIAlertController.showAlert(
                    title: "Success",
                    message: "Profile Updated Successfully ✅",
                    viewController: self
                )
            } else {
                print("❌ No user found with email: \(loggedInEmail)")
            }
        } catch {
            print("❌ Failed to update user: \(error)")
        }
    }
}
