import UIKit

class MyOrderViewController: UIViewController, ChangeAddressDelegate {

    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblNumberOfRatings: UILabel!
    @IBOutlet weak var lblRestoruntName: UILabel!
    @IBOutlet weak var lblTotalTitle: UILabel!
    @IBOutlet weak var lblDeliveryCostTitle: UILabel!
    @IBOutlet weak var lblSubTotalTitle: UILabel!
    @IBOutlet weak var lblDeliveryInstruction: UILabel!
    @IBOutlet var mainView: UIView!
    // MARK: - IBOutlets
    @IBOutlet weak var lblAddress: UILabel!  // Displays the selected delivery address
    @IBOutlet weak var btnCheckOut: UIButton!  // Button to proceed to checkout
    @IBOutlet weak var lblTotal: UILabel!  // Shows total cost including delivery
    @IBOutlet weak var lbldeliveryCost: UILabel!  // Shows delivery charges
    @IBOutlet weak var lblsubTotal: UILabel!  // Shows subtotal of products
    @IBOutlet weak var btnAddNotes: UIButton!  // Button to add notes to the order
    @IBOutlet weak var tblMyOrderView: UITableView!  // TableView displaying order items

    // MARK: - Properties
    let deliveryCost: Double = 5.0  // Fixed delivery cost

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide vertical scroll indicator for cleaner look
        tblMyOrderView.showsVerticalScrollIndicator = false

        // Register custom table view cell for order items
        tblMyOrderView.register(
            UINib(
                nibName: Main.CellIdentifiers.MyOrderTableViewCell,
                bundle: nil
            ),
            forCellReuseIdentifier: Main.CellIdentifiers.MyOrderTableViewCell
        )

        // Set navigation title with a back button
        setLeftAlignedTitleWithBack(
            Main.NavTitle.myOrder,
            target: self,
            action: #selector(BackBtnTapped)
        )

        // Style checkout button
        EditStyle.setborder(textfields: [btnCheckOut], cornerRadious: 28)

        // Calculate and display subtotal, delivery, and total
        calculateTotals()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        applyLocalizatin()
    }

    func applyLocalizatin() {
        lblRestoruntName.text = Main.OrderDetailAndCheckout.restaurantName
        lblRatings.text = Main.OrderDetailAndCheckout.ratings
        lblNumberOfRatings.text = Main.OrderDetailAndCheckout.numberOfRatings
        lblDeliveryInstruction.text =
            Main.OrderDetailAndCheckout.deliveryInstruction
        lblSubTotalTitle.text = Main.OrderDetailAndCheckout.subtotalTitle
        lblDeliveryCostTitle.text =
            Main.OrderDetailAndCheckout.deliveryCostTitle
        lblTotalTitle.text = Main.OrderDetailAndCheckout.totalTitle
        btnCheckOut.setTitle(Main.OrderDetailAndCheckout.btnCheckout, for: .normal)
        
    }

    // MARK: - ChangeAddressDelegate
    /// Updates the delivery address label when a new address is selected
    func didSelectAddress(_ address: String) {
        lblAddress.text = address
    }

    // MARK: - Calculate Totals
    /// Computes subtotal, delivery cost, and total, and updates the UI
    func calculateTotals() {
        let subtotal = app.arrOrderDetail.reduce(0) {
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

    func applyTheme() {
        let theme = ThemeManager.shared

        mainView.backgroundColor = theme.backgroundColor()
        btnCheckOut.setTitleColor(.white, for: .normal)
        btnCheckOut.backgroundColor = theme.backgroundColor()
        tblMyOrderView.backgroundColor = theme.backgroundColor()
        btnAddNotes.setTitleColor(theme.primaryButtonBackground(), for: .normal)
        lblTotal.textColor = theme.primaryButtonBackground()
        lbldeliveryCost.textColor = theme.primaryButtonBackground()
        lblTotal.textColor = theme.primaryButtonBackground()
        btnCheckOut.backgroundColor = theme.primaryButtonBackground()
        lblsubTotal.textColor = theme.primaryButtonBackground()
    }

    @IBAction func btnCheckOutClick(_ sender: Any) {
        // Navigate to checkout screen
        let storyboard = UIStoryboard(
            name: Main.StoryBoard.MoreStoryBoard,
            bundle: nil
        )
        if let checkoutVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.Checkout
        ) as? CheckOutViewController {
            // Pass the selected order items
            checkoutVc.arrCheckOutData = app.arrOrderDetail
            self.navigationController?.pushViewController(
                checkoutVc,
                animated: true
            )
        }
    }
}
