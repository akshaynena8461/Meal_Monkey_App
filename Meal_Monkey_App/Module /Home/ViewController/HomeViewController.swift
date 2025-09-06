import CoreData
import UIKit

class HomeViewController: UIViewController, HomeTableViewCellDelegate,
    ChangeAddressDelegate
{

    // MARK: - IBOutlets
    @IBOutlet weak var lblAddress: UILabel!  // Label to show selected address
    @IBOutlet weak var txtSearchFood: UITextField!  // TextField for searching products
    @IBOutlet weak var tblHomeView: UITableView!  // TableView for home screen content

    // MARK: - Variables
    var selectedCategory: ProductCategory = .All  // Currently selected category for filtering
    var objProductCategory: ProductModel?
    static var arrProductData: [ProductModel] = []  // Full product data array
    var arrRecentItem: [ProductModel] = []  // Recently viewed items
    var filteredProducts: [ProductModel] = []  // Filtered products based on category or search
    var searchText: String = ""  // Current search text
    var currentUserName: String = ""  // Logged in user's name

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
               self,
               selector: #selector(updateCartBadge),
               name: .cartUpdated,
               object: nil
           )
        
        txtSearchFood.placeholder = LanguageManager.shared.localizedString(for: "8461_search_food")
        
        fetchUserData()  // Fetch logged-in user data
        tblHomeView.showsVerticalScrollIndicator = false
        tabBarController?.tabBar.isHidden = false

        // Set greeting title
        setLeftAlignedTitle("Good morning \(currentUserName)!")

        // Set cart button in navigation
        setCartButton(target: self, action: #selector(CartButtonTapped))

        // Style the search text field
        EditStyle.setborder(textfields: [txtSearchFood], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearchFood], paddingWidth: 34)

        // Register custom table view cell
        tblHomeView.register(
            UINib(nibName: Main.CellIdentifiers.HomeTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifiers.HomeTableViewCell
        )

        // Listen for changes in search text
        txtSearchFood.addTarget(
            self,
            action: #selector(searchTextChanged),
            for: .editingChanged
        )

        // Fetch product data from API
        let productUrl =
            "https://mocki.io/v1/61d284ed-b0a1-493c-805c-efb4f68fdc53"
        APICalls.getProductData(from: productUrl, modelType: ProductModel.self)
        { products in
            DispatchQueue.main.async {
                Self.arrProductData = products
                self.filteredProducts = Self.arrProductData
                self.tblHomeView.reloadData()
            }
        }
        tblHomeView.reloadData()
    }

    @objc private func updateCartBadge() {
        setCartButton(target: self, action: #selector(CartButtonTapped))
    }

    
    // MARK: - Fetch User Data
    func fetchUserData() {
        let context = app.persistentContainer.viewContext

        guard
            let loggedInEmail = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            )
        else {
            print("No logged in user found")
            return
        }

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(
            format: "email == %@",
            loggedInEmail
        )

        do {
            let users = try context.fetch(fetchRequest)
            if let currentUser = users.first as? User {
                currentUserName = "\(currentUser.name ?? "Alise")"
            }
        } catch {
            print("Failed to fetch User: \(error)")
        }
    }

    // MARK: - Address Selection
    @IBAction func btnCurrentLocationClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryBoard, bundle: nil)
        if let changeAddressVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.Address
        ) as? ChangeAddressViewController {
            self.navigationController?.pushViewController(
                changeAddressVc,
                animated: true
            )
        }
    }

    func didSelectAddress(_ address: String) {
        lblAddress.text = address
    }

    // MARK: - Search Handling
    @objc func searchTextChanged() {
        searchText = txtSearchFood.text?.lowercased() ?? ""
        filterProducts()
    }

    /// Filters products based on selected category and search text
    func filterProducts() {
        let searchText = txtSearchFood.text?.lowercased() ?? ""
        filteredProducts = Self.arrProductData.filter { product in
            let matchesCategory =
                (selectedCategory == .All)
                || (product.objProductCategory == selectedCategory)
            let matchesName =
                searchText.isEmpty
                || product.strProductName.lowercased().contains(searchText)
            return matchesCategory && matchesName
        }
        tblHomeView.reloadData()
    }

    // MARK: - Lifecycle Updates
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Restore saved address
        if let savedAddress = UserDefaults.standard.string(
            forKey: "SelectedAddress"
        ) {
            lblAddress.text = savedAddress
        }
        fetchUserData()
        // Load recent items
        arrRecentItem = RecentItemsHelper.shared.getRecentItems()
        txtSearchFood.placeholder = LanguageManager.shared.localizedString(for: "8461_search_food")
        tblHomeView.reloadData()
    }

    // MARK: - Cart Navigation
    @objc func CartButtonTapped() {
        let storyboard = UIStoryboard(name: Main.StoryBoard.ProductStoryBoard, bundle: nil)
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.Cart
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                cartVc,
                animated: true
            )
        }
    }

    // MARK: - HomeTableViewCellDelegate Methods
    func HomeTableViewCell(
        _ cell: HomeTableViewCell,
        didSelectCategory category: ProductCategory
    ) {
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
        // Add selected product to recent items
        RecentItemsHelper.shared.addProduct(product)

        // Navigate to Product Detail page
        let storyboard = UIStoryboard(name: Main.StoryBoard.ProductStoryBoard, bundle: nil)
        if let detailVC = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.ProductDetail
        ) as? ProductDetailViewController {
            detailVC.products = product
            self.navigationController?.pushViewController(
                detailVC,
                animated: true
            )
        }

        // Refresh recent items
        arrRecentItem = RecentItemsHelper.shared.getRecentItems()
        tblHomeView.reloadData()
    }
}
