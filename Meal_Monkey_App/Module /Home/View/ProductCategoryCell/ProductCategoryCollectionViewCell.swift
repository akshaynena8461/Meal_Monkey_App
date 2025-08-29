import UIKit

class ProductCategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblCategoryName: UILabel!  // Label to display category name
    @IBOutlet weak var imgCategory: UIImageView!  // ImageView to display category image

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Rounded corners for category image
        imgCategory.layer.cornerRadius = 10
        imgCategory.clipsToBounds = true
    }

    // MARK: - Configure Cell
    /// Configures the cell with category information
    /// - Parameter category: ProductCategory enum representing category type
    func confingProductCategory(category: ProductCategory) {
        // Set the label text to the raw value of the enum
        lblCategoryName.text = category.rawValue

        // Set the category image based on the selected category
        switch category {
        case .All:
            imgCategory.image = UIImage(named: Main.Image.ic_butternaan)
        case .Punjabi:
            imgCategory.image = UIImage(named: Main.Image.ic_paneertikka)
        case .Chinese:
            imgCategory.image = UIImage(named: Main.Image.ic_hakkanoodles)
        case .Gujarati:
            imgCategory.image = UIImage(named: Main.Image.Ic_Khaman_Dhokla)
        case .SouthIndian:
            imgCategory.image = UIImage(named: Main.Image.ic_masaladosa)
        case .WesternFood:
            imgCategory.image = UIImage(named: Main.Image.ic_margherita_pizza)
        }

    }
}
