import UIKit
import Lottie

class DessertsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var txtSearch: UITextField!         // Search bar for filtering desserts
    @IBOutlet weak var tblDessertsView: UITableView!  // Table view to display dessert list
    @IBOutlet weak var lblNoProduct: UILabel!         // Label shown when no products match search

    // MARK: - Properties
    var selectedProductType: ProductType = .Desserts  // Current category selected
    var filteredProducts: [ProductModel] = []         // Filtered products based on search
    private var isSearching = false                   // Flag to check if user is searching

    // Computed property for the current product list based on selected type
    var arrProducts: [ProductModel] {
        switch selectedProductType {
        case .food:
            return HomeViewController.arrProductData.filter { $0.objProductType == .food }
        case .Desserts:
            return HomeViewController.arrProductData.filter { $0.objProductType == .Desserts }
        case .Beverages:
            return HomeViewController.arrProductData.filter { $0.objProductType == .Beverages }
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
               self,
               selector: #selector(updateCartBadge),
               name: .cartUpdated,
               object: nil
           )
        
        // Hide "No Product" label initially
        lblNoProduct.isHidden = true

        // Style the search text field
        EditStyle.setborder(textfields: [txtSearch], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)

        tblDessertsView.showsVerticalScrollIndicator = false

        // Add target for search text changes
        txtSearch.addTarget(
            self,
            action: #selector(searchTextChanged(_:)),
            for: .editingChanged
        )

        // Initially show all products for the selected type
        filteredProducts = arrProducts

        // Set navigation title based on selected product type
        switch selectedProductType {
        case .food:
            setLeftAlignedTitleWithBack("Food", target: self, action: #selector(BackBtnTapped))
        case .Beverages:
            setLeftAlignedTitleWithBack("Beverages", target: self, action: #selector(BackBtnTapped))
        case .Desserts:
            setLeftAlignedTitleWithBack("Desserts", target: self, action: #selector(BackBtnTapped))
        }

        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(CartBtnTapped))

        // Register table view cell
        tblDessertsView.register(
            UINib(nibName: Main.CellIdentifiers.DessertsTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifiers.DessertsTableViewCell
        )
    }
    
    func setEmptyBackgroundViewWithLottie(animationName: String) {
        let emptyView = UIView(frame: tblDessertsView.bounds)

           let animationView = LottieAnimationView(name: animationName)
           animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
           animationView.center = emptyView.center
           animationView.contentMode = .scaleAspectFit
           animationView.loopMode = .loop
           animationView.play()

           emptyView.addSubview(animationView)
           tblDessertsView.backgroundView = emptyView

    }
    
    @objc func updateCartBadge(){
        setCartButton(target: self, action: #selector(CartBtnTapped))
    }

    // MARK: - Search Functionality
    @objc private func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text?.lowercased() ?? ""

        if searchText.isEmpty {
            // Show all products if search is empty
            isSearching = false
            filteredProducts = arrProducts
        } else {
            // Filter products based on search text
            isSearching = true
            filteredProducts = arrProducts.filter { product in
                product.strProductName.lowercased().contains(searchText)
            }
        }

        // Show empty state only if no products
        if filteredProducts.isEmpty {
            setEmptyBackgroundViewWithLottie(animationName: "empty")
        } else {
            tblDessertsView.backgroundView = nil
        }

        // Reload table view
        tblDessertsView.reloadData()
    }

    // MARK: - Navigation Actions
    @objc func CartBtnTapped() {
        print("CartBtnTapped")
        let storyboard = UIStoryboard(name: Main.StoryBoard.ProductStoryBoard, bundle: nil)
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(cartVc, animated: true)
        }
    }

    @objc func BackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
