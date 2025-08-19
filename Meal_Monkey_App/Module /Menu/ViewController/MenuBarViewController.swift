import UIKit

// MARK: - MenuBarViewController
class MenuBarViewController: UIViewController {

    // MARK: - Properties
    /// Array of menu data used to populate the table view
    var arrMenuData: [MenuModel] = MenuModel.addMenuData()

    // MARK: - Outlets
    @IBOutlet weak var txtSearch: UITextField!   // Search text field at top
    @IBOutlet weak var tblMenuView: UITableView! // Table view to show menu categories

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set table view background to clear
        tblMenuView.backgroundColor = .clear

        // Set title aligned to the left
        setLeftAlignedTitle("Menu")
        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(openCart))

        // Hide vertical scroll indicator
        tblMenuView.showsVerticalScrollIndicator = false

        // Customize search text field with border and padding
        EditStyle.setborder(textfields: [txtSearch], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)

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
            self.navigationController?.pushViewController(cartVc, animated: true)
        }
    }

    /// Placeholder action for a menu button tap
    @objc func menuBtnTapped() {
        print("Menu Btn")
    }
}
