import UIKit

// MARK: - CheckOutViewController
class CheckOutViewController: UIViewController, ChangeAddressDelegate {

    @IBOutlet weak var viewinThankYouScrollView: UIView!
    // MARK: - IBOutlets
    @IBOutlet weak var viewinAddtoCartScrollView: UIView!
    @IBOutlet weak var lblAddress: UILabel!  // Displays selected delivery address
    @IBOutlet weak var btnChangeAddress: UIButton!  // Button to open change address screen
    @IBOutlet weak var btnBackToHome: UIButton!  // Button to go back to Home
    @IBOutlet weak var btnTrackMyOrder: UIButton!  // Button to track order
    @IBOutlet weak var thankYouScrollView: UIScrollView!  // Scroll view for Thank You page
    @IBOutlet weak var btnCloseThankYou: UIButton!  // Button to close Thank You page
    @IBOutlet weak var ThankYouPage: UIView!  // Thank You page view
    @IBOutlet weak var backView: UIView!  // Semi-transparent background overlay
    @IBOutlet weak var stackDelivery: UIStackView!  // Stack view for delivery/payment options
    @IBOutlet weak var btnAddCard: UIButton!  // Button to add a new card
    @IBOutlet weak var txtLastName: UITextField!  // Input for cardholder last name
    @IBOutlet weak var txtFirstName: UITextField!  // Input for cardholder first name
    @IBOutlet weak var txtSecurityCode: UITextField!  // Input for card CVV/CVC
    @IBOutlet weak var txtYear: UITextField!  // Card expiry year
    @IBOutlet weak var txtMonth: UITextField!  // Card expiry month
    @IBOutlet weak var txtCardNumber: UITextField!  // Card number input
    @IBOutlet weak var btnClose: UIButton!  // Close Add Card page
    @IBOutlet weak var addCardPageView: UIView!  // Add Card page
    @IBOutlet weak var btnSendOrder: UIButton!  // Send order button
    @IBOutlet weak var lblTotal: UILabel!  // Displays total cost
    @IBOutlet weak var lblDiscount: UILabel!  // Displays discount amount
    @IBOutlet weak var lblDeliveryCost: UILabel!  // Displays delivery cost
    @IBOutlet weak var lblSubTotal: UILabel!  // Displays subtotal
    @IBOutlet weak var tblCheckOutView: UITableView!  // Table view for payment options
    @IBOutlet weak var viewScroll: UIScrollView!  // Scroll view containing checkout page
    @IBOutlet weak var checkoutDetailPage: UIView!  // Checkout details page view
    @IBOutlet weak var btnAddAnotherCard: UIButton!  // Button to add another card

    // MARK: - Variables
    var arrCheckOutData: [ProductModel] = []  // Array of products in checkout
    var deliveryCost: Double = 5.0  // Default delivery cost
    var discountCost: Double = 4.0  // Default discount amount
    var selectedPaymentIndex: Int = 0  // Default selectPaymentIndex

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial UI setup
        backView.isHidden = true
        tblCheckOutView.showsVerticalScrollIndicator = false
        thankYouScrollView.showsVerticalScrollIndicator = false
        viewScroll.showsVerticalScrollIndicator = false

        // Set navigation title with back button
        setLeftAlignedTitleWithBack(
            "Checkout",
            target: self,
            action: #selector(BackBtnTapped)
        )

        // Add padding for textfields
        EditStyle.setPadding(
            textFields: [
                txtCardNumber, txtMonth, txtYear, txtSecurityCode, txtFirstName,
                txtLastName,
            ],
            paddingWidth: 34
        )

        // Add rounded borders for buttons and textfields
        EditStyle.setborder(
            textfields: [
                txtCardNumber, txtMonth, txtYear, txtSecurityCode, txtFirstName,
                txtLastName, btnAddCard, btnSendOrder, btnAddAnotherCard,
                btnTrackMyOrder,
            ],
            cornerRadious: 28
        )

        // Style scroll views and pages
        scrollViewStyle(
            scrollView: [viewScroll, thankYouScrollView],
            cornerRadious: 20
        )
        pageStyle(page: [addCardPageView, ThankYouPage], cornerRadious: 20)
        EditStyle.setborder(textfields: [btnSendOrder], cornerRadious: 28)

        setCornerRadius(uiView: [
            viewinThankYouScrollView, viewinAddtoCartScrollView,
        ])

        // Register custom table view cells
        tblCheckOutView.register(
            UINib(nibName: "CaseOnDeliveryCell", bundle: nil),
            forCellReuseIdentifier: "CaseOnDeliveryCell"
        )
        tblCheckOutView.register(
            UINib(nibName: "CardViewCell", bundle: nil),
            forCellReuseIdentifier: "CardViewCell"
        )
        tblCheckOutView.register(
            UINib(nibName: "UPIViewCell", bundle: nil),
            forCellReuseIdentifier: "UPIViewCell"
        )

        // Calculate totals initially
        calculateTotals()
    }

    func setCornerRadius(uiView: [UIView]) {
        for page in uiView {
            page.layer.cornerRadius = 42
            page.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner,
            ]
            page.clipsToBounds = true
            page.layer.shadowColor = UIColor.black.cgColor
            page.layer.shadowOpacity = 0.3
            page.layer.shadowOffset = CGSize(width: 0, height: -2)
            page.layer.shadowRadius = 30
        }
    }

    // MARK: - UI Helper Functions
    func pageStyle(page: [UIView], cornerRadious: CGFloat) {
        for item in page {
            item.layer.cornerRadius = cornerRadious
            item.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner,
            ]
        }
    }

    func scrollViewStyle(scrollView: [UIScrollView], cornerRadious: CGFloat) {
        for item in scrollView {
            item.layer.cornerRadius = cornerRadious
            item.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner,
            ]
            item.layer.shadowColor = UIColor.black.cgColor
            item.layer.shadowOpacity = 0.3
            item.layer.shadowOffset = CGSize(width: 0, height: -2)
            item.layer.shadowRadius = 10
        }
    }

    // MARK: - ChangeAddressDelegate
    func didSelectAddress(_ address: String) {
        lblAddress.text = address
    }

    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedAddress = UserDefaults.standard.string(
            forKey: "SelectedAddress"
        ) {
            lblAddress.text = savedAddress
        }
    }

    // MARK: - Calculate totals
    func calculateTotals() {
        let subtotal = arrCheckOutData.reduce(0) {
            $0 + ($1.doubleProductPrice * Double($1.intProductQty!))
        }
        lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lblDeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        lblDiscount.text = "-$\(String(format: "%.2f", discountCost))"
        lblTotal.text =
            "$\(String(format: "%.2f", subtotal + deliveryCost - discountCost))"
    }

    // MARK: - Actions
    @IBAction func btnChangeAddressClick(_ sender: Any) {
        // Open Change Address screen
        let storyboard = UIStoryboard(name: "MoreStoryBoard", bundle: nil)
        if let changeAddressVc = storyboard.instantiateViewController(
            withIdentifier: "ChangeAddressViewController"
        ) as? ChangeAddressViewController {
            changeAddressVc.delegate = self
            self.navigationController?.pushViewController(
                changeAddressVc,
                animated: true
            )
            self.tabBarController?.tabBar.isHidden = false
        }
    }

    @IBAction func btnCloseThankYouClick(_ sender: Any) {
        // Close Thank You page and show checkout page
        ThankYouPage.isHidden = true
        backView.isHidden = true
        checkoutDetailPage.isHidden = false
        addCardPageView.isHidden = true

        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.ThankYouPage.transform = CGAffineTransform(
                    translationX: 0,
                    y: self.view.frame.height
                )
            }
        ) { _ in
            self.ThankYouPage.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }

    @IBAction func btnSendOrderClick(_ sender: Any) {
        // Show Thank You page after sending order
        ThankYouPage.isHidden = false
        addCardPageView.isHidden = true
        checkoutDetailPage.isHidden = true
        backView.isHidden = false

        UIView.animate(withDuration: 0.3) {
            self.ThankYouPage.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }

    @objc func BackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnAddCardClick(_ sender: Any) {
        // Show Add Card page
        backView.isHidden = false
        checkoutDetailPage.isHidden = true
        addCardPageView.isHidden = false
        ThankYouPage.isHidden = true

        UIView.animate(withDuration: 0.3) {
            self.addCardPageView.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }

    @IBAction func btnCloseClick(_ sender: Any) {
        // Close Add Card page
        backView.isHidden = true
        checkoutDetailPage.isHidden = false
        addCardPageView.isHidden = true

        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.addCardPageView.transform = CGAffineTransform(
                    translationX: 0,
                    y: self.view.frame.height
                )
            }
        ) { _ in
            self.addCardPageView.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }

    // MARK: - Add Card Logic
    func addCard() {
        var newCard = PaymentModel()
        newCard.strCardNumber = txtCardNumber.text
        app.arrCard.append(newCard)

        if let last4 = newCard.strCardNumber?.suffix(4) {
            print("Added card **** **** **** \(last4)")
        }
    }

    @IBAction func btnAddAnotherCardClick(_ sender: Any) {
        // Validate card number
        guard
            let number = txtCardNumber.text?.trimmingCharacters(
                in: .whitespacesAndNewlines
            ), !number.isEmpty
        else {
            UIAlertController.showAlert(
                title: "Error",
                message: "Please enter a card number.",
                viewController: self
            )
            return
        }

        let digitOnly = CharacterSet.decimalDigits.isSuperset(
            of: CharacterSet(charactersIn: number)
        )
        guard digitOnly, number.count == 16 else {
            UIAlertController.showAlert(
                title: "Invalid Card",
                message: "Card number must be exactly 16 digits.",
                viewController: self
            )
            return
        }

        // Add card and update table view
        addCard()
        UIAlertController.showAlert(
            title: "Success",
            message: "Card Added Successfully",
            viewController: self
        )
        DispatchQueue.main.async { self.tblCheckOutView.reloadData() }

        // Close Add Card page
        backView.isHidden = true
        tblCheckOutView.isHidden = false
        checkoutDetailPage.isHidden = false
        btnAddAnotherCard.isHidden = false

        UIView.animate(withDuration: 0.3) {
            self.addCardPageView.transform = CGAffineTransform(
                translationX: 0,
                y: self.view.frame.height
            )
        } completion: { _ in
            self.addCardPageView.isHidden = true
        }

        self.tabBarController?.tabBar.isHidden = false
        txtCardNumber.text = ""
    }

    @IBAction func btnTrackMyOrderClick(_ sender: Any) {
        // Implement order tracking logic here
    }

    @IBAction func btnBackToHomeClick(_ sender: Any) {
        showMainTabBar()
    }
}
