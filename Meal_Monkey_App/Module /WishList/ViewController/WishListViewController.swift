import UIKit

class WishListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblEmpty: UILabel!        // Label shown when wishlist is empty
    @IBOutlet weak var tblWishlist: UITableView! // TableView to display wishlist items

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the navigation title with back button
        setLeftAlignedTitleWithBack(
            "Wishlist",
            target: self,
            action: #selector(backBtnTapped)
        )

        // Add cart button on navigation bar
        setCartButton(target: self, action: #selector(cartBtnTapped))

        // Register custom cell for the wishlist table view
        tblWishlist.register(
            UINib(nibName: Main.CellIdentifiers.CartTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifiers.CartTableViewCell
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch current logged-in user
        guard
            let currentUserEmail = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            ),
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail
            )
        else {
            return
        }

        // Fetch wishlist product IDs from Core Data for the current user
        let wishlistIds = CoreDataManager.shared.fetchWishlistIds(for: user)

        // Filter the global product data to only include products in the wishlist
        app.arrWishList = HomeViewController.arrProductData.filter {
            wishlistIds.contains($0.intId)
        }

        // Show or hide the "empty" label based on wishlist count
        lblEmpty.isHidden = !app.arrWishList.isEmpty
        
        // Reload table view to reflect the latest wishlist
        tblWishlist.reloadData()
    }

    // MARK: - Button Actions

    @objc func backBtnTapped() {
        // Navigate back to the previous screen
        self.navigationController?.popViewController(animated: true)
    }

    @objc func cartBtnTapped() {
        // Navigate to the CartViewController
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
