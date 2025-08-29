import UIKit

class PaymentViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblEmpty: UILabel!  // Label shown when there are no cards
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var viewScroll: UIScrollView!  // ScrollView for card entry form
    @IBOutlet weak var backView: UIView!  // Darkened background when adding a card
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var addCardPageView: UIView!  // Card entry form container
    @IBOutlet weak var btnAddAnotherDebitOrCreditCard: UIButton!
    @IBOutlet weak var tblPaymentView: UITableView!  // Table for displaying saved cards
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var btnClose: UIButton!

    var currentUserEmail = UserDefaults.standard.string(
        forKey: "loggedInUserEmail"
    )
    var card: PaymentModel?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateCartBadge),
            name: .cartUpdated,
            object: nil
        )

        // Hide the card entry page and background initially
        backView.isHidden = true
        addCardPageView.isHidden = true

        // Show "No cards" label if the card list is empty
        lblEmpty.isHidden = !app.arrCard.isEmpty

        // Apply styles to scroll and page views
        scrollViewStyle(scroll: [viewScroll], cornerRadious: 20)
        pageStyle(page: [addCardPageView], cornerRadious: 20)

        // Add padding and border styling to text fields and buttons
        EditStyle.setPadding(
            textFields: [
                txtCardNumber, txtMonth, txtYear, txtSecurityCode, txtFirstName,
                txtLastName,
            ],
            paddingWidth: 34
        )

        EditStyle.setborder(
            textfields: [
                txtCardNumber, txtMonth, txtYear, txtSecurityCode,
                txtFirstName, txtLastName, btnAddCard,
                btnAddAnotherDebitOrCreditCard,
            ],
            cornerRadious: 28
        )

        // Set navigation title and buttons
        setLeftAlignedTitleWithBack(
            "Payment Details",
            target: self,
            action: #selector(BackBtnTapped)
        )
        setCartButton(target: self, action: #selector(CartBtnTapped))

        // Register the payment table view cell
        tblPaymentView.register(
            UINib(nibName: Main.CellIdentifiers.PaymentTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifiers.PaymentTableViewCell
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserCards()
    }

    @objc func updateCartBadge() {
        setCartButton(target: self, action: #selector(CartBtnTapped))
    }

    // MARK: - UI Styling Functions
    func pageStyle(page: [UIView], cornerRadious: CGFloat) {
        for item in page {
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

    func scrollViewStyle(scroll: [UIScrollView], cornerRadious: CGFloat) {
        for item in scroll {
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

    // MARK: - Navigation Actions
    @objc func CartBtnTapped() {
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

    @objc func BackBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    private func fetchUserCards() {
        guard let currentUserEmail = currentUserEmail,
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail
            )
        else {
            lblEmpty.isHidden = false
            return
        }

        app.arrCard = CoreDataManager.shared.fetchCards(for: user)
        lblEmpty.isHidden = !app.arrCard.isEmpty
        tblPaymentView.reloadData()
    }

    // MARK: - Button Actions
    @IBAction func btnAddCardClick(_ sender: Any) {
        // Step 1: Validate Card Number
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
        guard
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail ?? ""
            )
        else {
            return
        }

        // Step 4: Save card (Core Data)
        CoreDataManager.shared.addCard(for: user, card: newCard)
        fetchUserCards()

        // Step 5: Update UI
        lblEmpty.isHidden = true
        UIAlertController.showAlert(
            title: "Success",
            message: "Card Added Successfully",
            viewController: self
        )

        DispatchQueue.main.async {
            self.tblPaymentView.reloadData()
        }

        // Animate hiding card entry view
        backView.isHidden = true
        tblPaymentView.isHidden = false
        btnAddAnotherDebitOrCreditCard.isHidden = false

        UIView.animate(withDuration: 0.3) {
            self.addCardPageView.transform = CGAffineTransform(
                translationX: 0,
                y: self.view.frame.height
            )
        } completion: { _ in
            self.addCardPageView.isHidden = true
        }

        // Step 6: Clear Input Fields
        txtCardNumber.text = ""
        txtFirstName.text = ""
        txtLastName.text = ""
        txtMonth.text = ""
        txtYear.text = ""
        txtSecurityCode.text = ""
    }

    @IBAction func btnAddAnotherDebitOrCreditCardClick(_ sender: Any) {
        backView.isHidden = false
        tblPaymentView.isHidden = true
        addCardPageView.isHidden = false
        btnAddAnotherDebitOrCreditCard.isHidden = true

        // Reset position before animation
        addCardPageView.transform = CGAffineTransform(
            translationX: 0,
            y: self.view.frame.height
        )

        UIView.animate(withDuration: 0.3) {
            self.addCardPageView.transform = .identity
        }
    }

    @IBAction func btnCloseClick(_ sender: Any) {
        backView.isHidden = true
        tblPaymentView.isHidden = false
        btnAddAnotherDebitOrCreditCard.isHidden = false

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
        }
    }
}
