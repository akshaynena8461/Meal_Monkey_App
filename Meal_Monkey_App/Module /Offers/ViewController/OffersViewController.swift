import UIKit

/// ViewController to display the list of latest offers
class OffersViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var btnCheckOffers: UIButton!  // Button to check more offers
    @IBOutlet weak var tblOffersView: UITableView!  // TableView to display offers

    // MARK: - Properties
    var arrOffers: [OfferModel] = OfferModel.addOffersData()  // Data source for offers

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateCartBadge),
            name: .cartUpdated,
            object: nil
        )

        // Hide vertical scroll indicator
        tblOffersView.showsVerticalScrollIndicator = false

        // Set the navigation title with left alignment
        setLeftAlignedTitle("Latest Offers")

        // Add cart button to the navigation bar
        setCartButton(target: self, action: #selector(CartBtnTapped))

        // Style the "Check Offers" button
        btnCheckOffers.layer.cornerRadius = 7.42

        // Register the custom OffersTableViewCell for the table view
        tblOffersView.register(
            UINib(nibName: Main.CellIdentifiers.OffersTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifiers.OffersTableViewCell
        )
    }

    @objc func updateCartBadge() {
        setCartButton(target: self, action: #selector(CartBtnTapped))
    }

    // MARK: - Actions
    /// Handles cart button tap
    @objc func CartBtnTapped() {
        print("Cart Tapped")
        let storyboard = UIStoryboard(name: Main.StoryBoard.ProductStoryBoard, bundle: nil)
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                cartVc,
                animated: true
            )
        }
    }

    /// Handles the "Check Offers" button tap
    @IBAction func btnCheckOffersClick(_ sender: Any) {
        // Implement functionality for checking offers here
    }
}
