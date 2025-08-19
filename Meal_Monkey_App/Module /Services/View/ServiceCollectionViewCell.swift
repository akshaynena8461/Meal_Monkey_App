import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imgView: UIImageView! // Image view to display the service image

    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Called when the cell is loaded from nib
        // You can add additional UI setup here if needed
    }

    // MARK: - Cell Configuration
    /// Configure the cell with an image
    /// - Parameter imgName: Name of the image asset to display
    func configServiceCell(imgName: String) {
        imgView.image = UIImage(named: imgName)
    }
}
