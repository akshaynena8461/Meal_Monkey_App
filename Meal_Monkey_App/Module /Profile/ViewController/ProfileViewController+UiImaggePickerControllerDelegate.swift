import UIKit

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Image Picker Delegate
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        // Retrieve the edited image from the picker info dictionary
        if let selectedImage = info[.editedImage] as? UIImage {
            // Set the selected image to the profile image view
            imgProfile.image = selectedImage
            
            // Optional: You could save the image to Core Data or local storage here
            // Example: saveProfileImageToCoreData(selectedImage)
        }
        
        // Dismiss the image picker
        dismiss(animated: true)
    }
}
