import UIKit

// MARK: - MoreViewController
// ViewController for displaying the "More" menu items
class MoreViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!          // Label for page title
    @IBOutlet weak var tblMoreView: UITableView!  // TableView for More menu items

    // MARK: - Data
    var arrMore = MoreModel.addMoreData()         // Array containing menu items

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the page title
        setLeftAlignedTitle("More")

        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(cartButtonTapped))

        // Create a UIBarButtonItem with a cart icon
        let cartButton = UIBarButtonItem(
            image: UIImage(systemName: "cart.fill"),
            style: .plain,
            target: self,
            action: #selector(cartButtonTapped)
        )

        // Set custom tint color for the cart icon
        cartButton.tintColor = UIColor(
            red: 74 / 255,
            green: 75 / 255,
            blue: 77 / 255,
            alpha: 1.0
        )

        // Add cart button to the navigation bar's right side
        self.navigationItem.rightBarButtonItem = cartButton

        // Register the custom cell for the table view
        tblMoreView.register(
            UINib(nibName: "MoreTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MoreTableViewCell"
        )
    }

    // MARK: - Actions
    /// Handles the cart button tap action
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        
        // Instantiate CartViewController and push it onto the navigation stack
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(cartVc, animated: true)
        }
    }
}
