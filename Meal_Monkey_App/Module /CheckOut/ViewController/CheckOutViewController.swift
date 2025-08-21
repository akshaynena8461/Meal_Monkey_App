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
    var currentUserEmail = UserDefaults.standard.string(
        forKey: "loggedInUserEmail"
    )

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
        fetchUserCards()
    }

    // MARK: - Calculate totals
    func calculateTotals() {
        let subtotal = arrCheckOutData.reduce(0) {
            $0 + ($1.doubleProductPrice * Double($1.intProductQty!))
        }
        print("subtotal \(subtotal)")

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
        btnChangeAddress.isHidden = false

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
        btnChangeAddress.isHidden = true

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
        btnChangeAddress.isHidden = true

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
        btnChangeAddress.isHidden = false

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
        let newCard = PaymentModel()
        newCard.intCardNumber = Int64(txtCardNumber.text ?? "")
        app.arrCard.append(newCard)

        let cardNumber = "String\(newCard.intCardNumber ?? 0)"
        let last4 = cardNumber.suffix(4)
        print("Added card **** **** **** \(last4)")

    }

    private func fetchUserCards() {
        guard let currentUserEmail = currentUserEmail,
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail
            )
        else {
            return
        }

        app.arrCard = CoreDataManager.shared.fetchCards(for: user)
        tblCheckOutView.reloadData()
    }

    @IBAction func btnAddAnotherCardClick(_ sender: Any) {
        guard
            let number = txtCardNumber.text?.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            !number.isEmpty
        else {
            UIAlertController.showAlert(
                title: "Error",
                message: "Please enter a card number.",
                viewController: self
            )
            return
        }

        // Ensure only digits & exactly 16 digits
        let isDigits = CharacterSet.decimalDigits.isSuperset(
            of: CharacterSet(charactersIn: number)
        )
        guard isDigits, number.count == 16 else {
            UIAlertController.showAlert(
                title: "Invalid Card",
                message: "Card number must be exactly 16 digits.",
                viewController: self
            )
            return
        }

        // Step 2: Build PaymentModel from inputs
        let cardId = Int.random(in: 1000...9999)
        let firstName = txtFirstName.text ?? ""
        let lastName = txtLastName.text ?? ""
        let cardNumber = Int64(number) ?? 0
        let securityCode = Int64(txtSecurityCode.text ?? "") ?? 0
        let expiryMonth = Int64(txtMonth.text ?? "") ?? 0
        let expiryYear = Int64(txtYear.text ?? "") ?? 0

        let newCard = PaymentModel(
            intCardId: cardId,
            intCardNumber: cardNumber,
            intMonth: expiryMonth,
            intYear: expiryYear,
            intSecurityCode: securityCode,
            strFirstName: firstName,
            strLastName: lastName
        )

        // Step 3: Fetch current user
        guard let currentUserEmail = currentUserEmail,
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail
            )
        else {
            UIAlertController.showAlert(
                title: "Error",
                message: "No logged-in user found.",
                viewController: self
            )
            return
        }

        // Step 4: Save card (Core Data)
        CoreDataManager.shared.addCard(for: user, card: newCard)
        fetchUserCards()

        // Step 5: Update UI
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
