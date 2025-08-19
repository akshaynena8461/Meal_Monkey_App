import CoreData
import UIKit

class CartViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var lblEmpty: UILabel!         // Label shown when cart is empty
    @IBOutlet weak var btnPlaceOrder: UIButton!   // Place Order button
    @IBOutlet weak var tblCartView: UITableView!  // Table view showing cart items

    // MARK: - Variables
    var products: ProductModel?                   // Optional product reference (not used here currently)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Show/hide empty label and place order button depending on cart
        if app.arrCart.isEmpty {
            lblEmpty.isHidden = false
            btnPlaceOrder.isHidden = true
        } else {
            lblEmpty.isHidden = true
            btnPlaceOrder.isHidden = false
        }

        // Set navigation title with a back button
        setLeftAlignedTitleWithBack(
            "Cart Page",
            target: self,
            action: #selector(backBtnTapped)
        )

        // Style the place order button
        EditStyle.setborder(textfields: [btnPlaceOrder], cornerRadious: 28)

        // Register CartTableViewCell for table view
        tblCartView.register(
            UINib(nibName: "CartTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CartTableViewCell"
        )

        tblCartView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Update empty label visibility
        lblEmpty.isHidden = !app.arrCart.isEmpty

        // Update wishlist flags for products
        updateWishlistData()

        // Fetch logged-in user from UserDefaults and Core Data
        if let loggedInUser = CoreDataManager.shared.fetchUserbyEmail(
            byEmail: UserDefaults.standard.string(forKey: "loggedInUserEmail") ?? ""
        ) {
            // Fetch cart for the current user
            app.arrCart = CoreDataManager.shared.fetchCart(for: loggedInUser)
            tblCartView.reloadData()
            lblEmpty.isHidden = !app.arrCart.isEmpty
        }
    }

    // MARK: - Navigation
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func cartBtnTapped() {
        // Navigate to CartViewController
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(cartVc, animated: true)
        }
    }

    // MARK: - Helper Methods
    /// Updates product objects to reflect whether they are in wishlist
    func updateWishlistData() {
        for item in HomeViewController.arrProductData {
            if app.arrWishList.firstIndex(where: { $0.intId == item.intId }) != nil {
                item.objAddFavorite = true
            } else {
                item.objAddFavorite = false
            }
        }
    }

    // MARK: - Actions
    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        // Fetch the current logged-in user
        guard
            let currentUserEmail = UserDefaults.standard.string(forKey: "loggedInUserEmail"),
            let user = CoreDataManager.shared.fetchUserbyEmail(byEmail: currentUserEmail)
        else {
            print("No logged in user found")
            return
        }

        // If the cart is not empty, save the order and clear the cart
        if !app.arrCart.isEmpty {
            // Save order in Core Data
            CoreDataManager.shared.saveOrder(for: user, products: app.arrCart)

            // Clear the cart
            CoreDataManager.shared.clearCart(for: user)
            app.arrCart.removeAll()
        }

        // Navigate to Order List screen
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let orderlistVc = storyboard.instantiateViewController(
            withIdentifier: "OrderListViewController"
        ) as? OrderListViewController {
            self.navigationController?.pushViewController(orderlistVc, animated: true)
        }

        // Update UI for empty cart
        lblEmpty.isHidden = false
        btnPlaceOrder.isHidden = true
        tblCartView.reloadData()
    }
}
