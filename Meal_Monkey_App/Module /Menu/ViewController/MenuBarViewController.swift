import Lottie
import UIKit

// MARK: - MenuBarViewController
class MenuBarViewController: UIViewController {

    private var animationView: LottieAnimationView?

    // MARK: - Properties
    /// Array of menu data used to populate the table view
    var arrMenuData: [MenuModel] = MenuModel.addMenuData()
    var filteredMenuData: [MenuModel] = []

    // MARK: - Outlets
    @IBOutlet weak var sideImage: UIImageView!
    @IBOutlet weak var lblEmpty: UILabel!
    // Show Empty Label if menu items is not found
    @IBOutlet weak var txtSearch: UITextField!  // Search text field at top
    @IBOutlet weak var tblMenuView: UITableView!  // Table view to show menu categories

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateCartBadge),
            name: .cartUpdated,
            object: nil
        )

        // Set table view background to clear
        tblMenuView.backgroundColor = .clear

        lblEmpty.isHidden = true
        filteredMenuData = arrMenuData

        // Set title aligned to the left
        setLeftAlignedTitle("Menu")
        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(openCart))

        // Hide vertical scroll indicator
        tblMenuView.showsVerticalScrollIndicator = false

        // Customize search text field with border and padding
        EditStyle.setborder(textfields: [txtSearch], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)

        txtSearch.addTarget(
            self,
            action: #selector(searchTextChanged),
            for: .editingChanged
        )
        // Register the custom table view cell
        tblMenuView.register(
            UINib(nibName: Main.CellIdentifiers.MenuTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifiers.MenuTableViewCell
        )
    }

    // MARK: - Actions
    /// Opens the cart view controller when cart button is tapped
    @objc func openCart() {
        print("Cart Page")
        let storyboard = UIStoryboard(
            name: Main.StoryBoard.ProductStoryBoard,
            bundle: nil
        )
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                cartVc,
                animated: true
            )
        }
    }

    @objc func updateCartBadge() {
        setCartButton(target: self, action: #selector(CartBtnTapped))
    }

    /// Placeholder action for a menu button tap
    @objc func menuBtnTapped() {
        print("Menu Btn")
    }

    // Search Functionality for Menu Items
    @objc func searchTextChanged() {
        guard let searchText = txtSearch.text?.lowercased(), !searchText.isEmpty
        else {
            // Search text empty → show all items
            filteredMenuData = arrMenuData
            tblMenuView.reloadData()
            return
        }

        // Filter menu
        filteredMenuData = arrMenuData.filter { menu in
            menu.strTitle?.lowercased().contains(searchText) ?? false
        }

        if filteredMenuData.isEmpty {
            // Nothing matched search → show empty state
            sideImage.isHidden = true
            setEmptyBackgroundViewWithLottie(tableView:tblMenuView,animationName: "empty", message: "No Products Found")
        } else {
            // Data found → hide empty state
            sideImage.isHidden = false
            tblMenuView.backgroundView = nil
        }
        tblMenuView.reloadData()
    }
}
