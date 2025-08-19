import UIKit

class PaymentViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblEmpty: UILabel! // Label shown when there are no cards
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var viewScroll: UIScrollView! // ScrollView for card entry form
    @IBOutlet weak var backView: UIView! // Darkened background when adding a card
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var addCardPageView: UIView! // Card entry form container
    @IBOutlet weak var btnAddAnotherDebitOrCreditCard: UIButton!
    @IBOutlet weak var tblPaymentView: UITableView! // Table for displaying saved cards
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var btnClose: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

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
                txtCardNumber, txtMonth, txtYear, txtSecurityCode, txtFirstName,
                txtLastName, btnAddCard, btnAddAnotherDebitOrCreditCard,
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
            UINib(nibName: "PaymentTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PaymentTableViewCell"
        )
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
        print("Cart Btn Tapped")
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(cartVc, animated: true)
        }
    }

    @objc func BackBtnTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Card Management
    func addCard() {
        var newCard = PaymentModel()
        newCard.strCardNumber = txtCardNumber.text
        app.arrCard.append(newCard)

        // Print last 4 digits for debug
        if let last4 = newCard.strCardNumber?.suffix(4) {
            print("Added card **** **** **** \(last4)")
        }
    }

    // MARK: - Button Actions
    @IBAction func btnAddCardClick(_ sender: Any) {
        // Validate card number input
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

        // Add card to the list
        addCard()
        lblEmpty.isHidden = !app.arrCard.isEmpty

        UIAlertController.showAlert(
            title: "Success",
            message: "Card Added Successfully",
            viewController: self
        )

        // Reload table view to show new card
        DispatchQueue.main.async {
            self.tblPaymentView.reloadData()
        }

        // Hide card entry view and show main payment view
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

        // Clear input fields
        txtCardNumber.text = ""
    }

    @IBAction func btnAddAnotherDebitOrCreditCardClick(_ sender: Any) {
        // Show card entry form
        backView.isHidden = false
        tblPaymentView.isHidden = true
        addCardPageView.isHidden = false
        btnAddAnotherDebitOrCreditCard.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.addCardPageView.transform = .identity
        }
    }

    @IBAction func btnCloseClick(_ sender: Any) {
        // Close card entry form
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
