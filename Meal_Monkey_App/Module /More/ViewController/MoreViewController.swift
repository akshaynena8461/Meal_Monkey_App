import UIKit

// MARK: - MoreViewController
// ViewController for displaying the "More" menu items
class MoreViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!  // Label for page title
    @IBOutlet weak var tblMoreView: UITableView!  // TableView for More menu items

    // MARK: - Data
    var arrMore = MoreModel.addMoreData()  // Array containing menu items

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateCartBadge),
            name: .cartUpdated,
            object: nil
        )

        // Set the page title
        setLeftAlignedTitle("More")
        tblMoreView.showsVerticalScrollIndicator = false

        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(cartButtonTapped))

        // Register the custom cell for the table view
        tblMoreView.register(
            UINib(nibName: Main.CellIdentifiers.MoreTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifiers.MoreTableViewCell
        )
    }
    
    @objc func updateCartBadge() {
        setCartButton(target: self, action: #selector(cartButtonTapped))
    }

    // MARK: - Actions
    /// Handles the cart button tap action
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: Main.StoryBoard.ProductStoryBoard, bundle: nil)

        // Instantiate CartViewController and push it onto the navigation stack
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
