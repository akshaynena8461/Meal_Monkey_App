import UIKit

class ProductCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgCategory.layer.cornerRadius = 10
    }
    

    func confingProductCategory(category: ProductCategory) {
        lblCategoryName.text = category.rawValue
        switch category {
        case .All:
            imgCategory.image = UIImage(named: "ic_butternaan")
        case .Punjabi:
            imgCategory.image = UIImage(named: "ic_paneertikka")
        case .Chinese:
            imgCategory.image = UIImage(named: "ic_hakkanoodles")
        case .Gujarati:
            imgCategory.image = UIImage(named: "Ic_Khaman_Dhokla")
        case .SouthIndian:
            imgCategory.image = UIImage(named: "ic_masaladosa")
        case .WesternFood:
            imgCategory.image = UIImage(named: "ic_margherita_pizza")
            
        }
      
    }

}
