import UIKit
import Lottie

class WishListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblEmpty: UILabel!        // Label shown when wishlist is empty
    @IBOutlet weak var tblWishlist: UITableView! // TableView to display wishlist items

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        lblEmpty.isHidden = true
        // Set the navigation title with back button
        setLeftAlignedTitleWithBack(
            Main.NavTitle.wishlist,
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
        
        if app.arrWishList.isEmpty {
            setEmptyBackgroundViewWithLottie(tableView:tblWishlist,animationName: "like button", message: Main.EmptyStateKeys.wishlistEmpty)
        }
        // Reload table view to reflect the latest wishlist
        setLeftAlignedTitleWithBack(
            Main.NavTitle.wishlist,
            target: self,
            action: #selector(backBtnTapped)
        )
        applyTheme()
        tblWishlist.reloadData()
    }
    
    func applyTheme(){
        let theme = ThemeManager.shared
        tblWishlist.backgroundColor = theme.backgroundColor()
        view.backgroundColor = theme.backgroundColor()
    }

    // MARK: - Button Actions

    @objc func backBtnTapped() {
        // Navigate back to the previous screen
        self.navigationController?.popViewController(animated: true)
    }

    @objc func cartBtnTapped() {
        // Navigate to the CartViewController
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
}
