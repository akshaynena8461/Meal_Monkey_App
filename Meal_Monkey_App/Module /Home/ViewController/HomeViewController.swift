import UIKit



class HomeViewController: UIViewController {

    @IBOutlet weak var txtSearchFood: UITextField!
    var selectedCategory: ProductCategory = .Gujarati
    @IBOutlet weak var tblHomeView: UITableView!
    
    static var arrProductData: [ProductModel] = ProductModel.addProductData()
    var arrRecentItem:[ProductModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tblHomeView.showsVerticalScrollIndicator = false
        tabBarController?.tabBar.isHidden = false
        setLeftAlignedTitle("Good morning Akshay!")
        setCartButton(target: self, action: #selector(CartButtonTapped))

        EditStyle.setborder(textfields: [txtSearchFood], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearchFood], paddingWidth: 34)

        tblHomeView.register(
            UINib(nibName: "HomeTableViewCell", bundle: nil),
            forCellReuseIdentifier: "HomeTableViewCell"
        )

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
