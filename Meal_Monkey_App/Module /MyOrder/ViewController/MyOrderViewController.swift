import UIKit

class MyOrderViewController: UIViewController, ChangeAddressDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var lblAddress: UILabel!        // Displays the selected delivery address
    @IBOutlet weak var btnCheckOut: UIButton!     // Button to proceed to checkout
    @IBOutlet weak var lblTotal: UILabel!         // Shows total cost including delivery
    @IBOutlet weak var lbldeliveryCost: UILabel!  // Shows delivery charges
    @IBOutlet weak var lblsubTotal: UILabel!      // Shows subtotal of products
    @IBOutlet weak var btnAddNotes: UIButton!     // Button to add notes to the order
    @IBOutlet weak var tblMyOrderView: UITableView! // TableView displaying order items

    // MARK: - Properties
    var arrOrderDetail: [ProductModel] = []       // Array containing products in the order
    let deliveryCost: Double = 5.0                // Fixed delivery cost

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide vertical scroll indicator for cleaner look
        tblMyOrderView.showsVerticalScrollIndicator = false

        // Register custom table view cell for order items
        tblMyOrderView.register(
            UINib(nibName: "MyOrderTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MyOrderTableViewCell"
        )

        // Set navigation title with a back button
        setLeftAlignedTitleWithBack(
            "My Order",
            target: self,
            action: #selector(BackBtnTapped)
        )

        // Style checkout button
        EditStyle.setborder(textfields: [btnCheckOut], cornerRadious: 28)

        // Calculate and display subtotal, delivery, and total
        calculateTotals()
    }

    // MARK: - ChangeAddressDelegate
    /// Updates the delivery address label when a new address is selected
    func didSelectAddress(_ address: String) {
        lblAddress.text = address
    }

    // MARK: - Calculate Totals
    /// Computes subtotal, delivery cost, and total, and updates the UI
    func calculateTotals() {
        let subtotal = arrOrderDetail.reduce(0) {
            $0 + ($1.doubleProductPrice * Double($1.intProductQty!))
        }

        lblsubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lbldeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        lblTotal.text = "$\(String(format: "%.2f", subtotal + deliveryCost))"
    }

    // MARK: - Actions
    @IBAction func btnAddNotesClick(_ sender: Any) {
        // TODO: Handle adding notes to the order
    }

    @objc func BackBtnTapped() {
        // Pop the view controller to go back
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnCheckOutClick(_ sender: Any) {
        // Navigate to checkout screen
        let storyboard = UIStoryboard(name: "MoreStoryBoard", bundle: nil)
        if let checkoutVc = storyboard.instantiateViewController(
            withIdentifier: "CheckOutViewController"
        ) as? CheckOutViewController {
            // Pass the selected order items
            checkoutVc.arrCheckOutData = app.arrOrder.flatMap { $0 }
            self.navigationController?.pushViewController(
                checkoutVc,
                animated: true
            )
        }
    }
}
