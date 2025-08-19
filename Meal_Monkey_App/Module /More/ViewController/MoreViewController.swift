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
