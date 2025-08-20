import UIKit

// MARK: - MenuBarViewController
class MenuBarViewController: UIViewController {

    // MARK: - Properties
    /// Array of menu data used to populate the table view
    var arrMenuData: [MenuModel] = MenuModel.addMenuData()
    var filteredMenuData: [MenuModel] = []

    // MARK: - Outlets
    @IBOutlet weak var lblEmpty: UILabel!
         // Show Empty Label if menu items is not found
    @IBOutlet weak var txtSearch: UITextField!  // Search text field at top
    @IBOutlet weak var tblMenuView: UITableView!  // Table view to show menu categories

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

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
            UINib(nibName: "MenuTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MenuTableViewCell"
        )
    }

    // MARK: - Actions
    /// Opens the cart view controller when cart button is tapped
    @objc func openCart() {
        print("Cart Page")
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

    /// Placeholder action for a menu button tap
    @objc func menuBtnTapped() {
        print("Menu Btn")
    }

    // Search Functionality for Menu Items
    @objc func searchTextChanged() {
        guard let searchText = txtSearch.text?.lowercased(), !searchText.isEmpty
        else {
            filteredMenuData = arrMenuData  // show all if empty
            lblEmpty.isHidden = !filteredMenuData.isEmpty
            tblMenuView.reloadData()
            return
        }

        filteredMenuData = arrMenuData.filter { menu in
            menu.strTitle?.lowercased().contains(searchText) ?? false
        }
        lblEmpty.isHidden = !filteredMenuData.isEmpty
        tblMenuView.reloadData()
    }
}
