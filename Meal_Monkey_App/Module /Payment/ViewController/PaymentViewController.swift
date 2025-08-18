import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var addCardPageView: UIView!
    @IBOutlet weak var btnAddAnotherDebitOrCreditCard: UIButton!
    @IBOutlet weak var tblPaymentView: UITableView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var btnClose: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        backView.isHidden = true

        lblEmpty.isHidden = true

        if app.arrCard.count == 0 {
            lblEmpty.isHidden = false
        }
        
        scrollViewStyle(scroll: [viewScroll], cornerRadious: 20)
        pageStyle(page: [addCardPageView], cornerRadious: 20)

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

        addCardPageView.isHidden = true
        setLeftAlignedTitleWithBack(
            "Payment Details",
            target: self,
            action: #selector(BackBtnTapped)
        )
        setCartButton(target: self, action: #selector(CartBtnTapped))

        tblPaymentView.register(
            UINib(nibName: "PaymentTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PaymentTableViewCell"
        )
    }

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

    @objc func CartBtnTapped() {
        print("Cart Btn Tapped")
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

    @objc func BackBtnTapped() {
        navigationController?.popViewController(animated: true)
    }

    func addCard() {
        var newCard = PaymentModel()
        newCard.strCardNumber = txtCardNumber.text
        app.arrCard.append(newCard)

        if let last4 = newCard.strCardNumber?.suffix(4) {
            print("Added card **** **** **** \(last4)")
        }
    }

    @IBAction func btnAddCardClick(_ sender: Any) {
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

        addCard()
        lblEmpty.isHidden = !app.arrCard.isEmpty
        UIAlertController.showAlert(
            title: "Success",
            message: "Card Added Successfully",
            viewController: self
        )

        DispatchQueue.main.async {
            self.tblPaymentView.reloadData()
        }

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
        txtCardNumber.text = ""
    }

    @IBAction func btnAddAnotherDebitOrCreditCardClick(_ sender: Any) {
        backView.isHidden = false
        tblPaymentView.isHidden = true
        addCardPageView.isHidden = false
        btnAddAnotherDebitOrCreditCard.isHidden = true
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
