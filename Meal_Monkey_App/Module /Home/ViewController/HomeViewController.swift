import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var txtSearchFood: UITextField!
  
    var selectedCategory:ProductCategory = .Gujarati
    
    var arrPopularProducts: [ProductModel] = []
    var arrMostPopularProducts: [ProductModel] = []

    @IBOutlet weak var tblHomeView: UITableView!
    var arrProductData: [ProductModel] = ProductModel.addProductData()

    override func viewDidLoad() {
        super.viewDidLoad()

        setLeftAlignedTitle("Good morning Akshay!")
        setCartButton(target: self, action: #selector(CartButtonTapped))

        arrPopularProducts = arrProductData.filter {
            $0.floatProductRating == 4.5
        }
        arrMostPopularProducts = arrProductData.filter {
            $0.floatProductRating == 5
        }
        
        EditStyle.setborder(textfields: [txtSearchFood], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearchFood], paddingWidth: 34)
        
        tblHomeView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        tblHomeView.reloadData()
        
    }

    @objc func CartButtonTapped() {
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

}
