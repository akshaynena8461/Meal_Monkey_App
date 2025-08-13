import UIKit



class HomeViewController: UIViewController,HomeTableViewCellDelegate {

    
    
    @IBOutlet weak var txtSearchFood: UITextField!
    var selectedCategory: ProductCategory = .All
    @IBOutlet weak var tblHomeView: UITableView!
    var objProductCategory:ProductModel?

    static var arrProductData: [ProductModel] = ProductModel.addProductData()
    var arrRecentItem:[ProductModel] = []
    var filteredProducts:[ProductModel] = []
    var searchText: String = ""
    

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

        
        txtSearchFood.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        filteredProducts = Self.arrProductData

        tblHomeView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        arrRecentItem = RecentItemsHelper.shared.getRecentItems()
        tblHomeView.reloadData()
    }
    
    @objc func searchTextChanged() {
        searchText = txtSearchFood.text?.lowercased() ?? ""
        tblHomeView.reloadData()
    }
    func filterProducts() {
        let searchText = txtSearchFood.text?.lowercased() ?? ""

        filteredProducts = Self.arrProductData.filter { product in
            let matchesCategory = (selectedCategory == .All) || (product.objProductCategory == selectedCategory)
            let matchesName = searchText.isEmpty || product.strProductName.lowercased().contains(searchText)
            return matchesCategory && matchesName
        }

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
    
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory) {
        selectedCategory = category
        filterProducts()
        DispatchQueue.main.async {
            self.tblHomeView.reloadData()
        }
    }

    func HomeTableViewCell(
        _ cell: HomeTableViewCell,
        didSelectProduct product: ProductModel
    ) {
        RecentItemsHelper.shared.addProduct(product)

        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(
            withIdentifier: "ProductDetailViewController"
        ) as? ProductDetailViewController {
            detailVC.product = product
            self.navigationController?.pushViewController(
                detailVC,
                animated: true
            )
        }

        arrRecentItem = RecentItemsHelper.shared.getRecentItems()
        tblHomeView.reloadData()
    }
}
