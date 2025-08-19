import UIKit

class DessertsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblTitle2: UILabel!       // Displays product type (e.g., Dessert)
    @IBOutlet weak var lblRating: UILabel!       // Displays product rating
    @IBOutlet weak var imgStar: UIImageView!     // Optional star icon for rating
    @IBOutlet weak var lblTitle: UILabel!        // Displays product name
    @IBOutlet weak var imgDessert: UIImageView!  // Displays product image
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Any additional setup after loading from nib
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure view for selected state if needed
    }

    // MARK: - Configure Cell
    func configDessertCell(dessert: ProductModel) {
        // Set product name
        lblTitle.text = dessert.strProductName
        
        // Set product type (e.g., Dessert, Beverage)
        lblTitle2.text = "\(dessert.objProductType)"
        
        // Set product rating as text
        lblRating.text = "\(dessert.floatProductRating)"
        
        // Set product image
        imgDessert.image = UIImage(named: dessert.strProductImage)
        
        // Optionally, you can also set the star image visibility or color based on rating
        // e.g., imgStar.tintColor = dessert.floatProductRating > 4 ? .systemYellow : .lightGray
    }
}
