import UIKit

class CheckOutViewController: UIViewController, ChangeAddressDelegate {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnChangeAddress: UIButton!
    @IBOutlet weak var btnBackToHome: UIButton!
    @IBOutlet weak var btnTrackMyOrder: UIButton!
    @IBOutlet weak var thankYouScrollView: UIScrollView!
    @IBOutlet weak var btnCloseThankYou: UIButton!
    @IBOutlet weak var ThankYouPage: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var stackDelivery: UIStackView!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var addCardPageView: UIView!
    @IBOutlet weak var btnSendOrder: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var tblCheckOutView: UITableView!
    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var checkoutDetailPage: UIView!
    @IBOutlet weak var btnAddAnotherCard: UIButton!

    var arrCheckOutData: [ProductModel] = []
    var deliveryCost: Double = 5.0
    var discountCost: Double = 4.0

    override func viewDidLoad() {
        super.viewDidLoad()

        backView.isHidden = true
        tblCheckOutView.showsVerticalScrollIndicator = false
        thankYouScrollView.showsVerticalScrollIndicator = false
        viewScroll.showsVerticalScrollIndicator = false

        setLeftAlignedTitleWithBack(
            "Checkout",
            target: self,
            action: #selector(BackBtnTapped)
        )

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
                txtLastName, btnAddCard, btnSendOrder, btnAddAnotherCard,
                btnTrackMyOrder,
            ],
            cornerRadious: 28
        )

        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]

        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.3
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10

        addCardPageView.layer.cornerRadius = 20
        addCardPageView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]

        thankYouScrollView.layer.cornerRadius = 20
        thankYouScrollView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]

        thankYouScrollView.layer.shadowColor = UIColor.black.cgColor
        thankYouScrollView.layer.shadowOpacity = 0.3
        thankYouScrollView.layer.shadowOffset = CGSize(width: 0, height: -2)
        thankYouScrollView.layer.shadowRadius = 10

        ThankYouPage.layer.cornerRadius = 20
        ThankYouPage.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]
        EditStyle.setborder(textfields: [btnSendOrder], cornerRadious: 28)

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

        calculateTotals()

    }

    func didSelectAddress(_ address: String) {
        lblAddress.text = address
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let savedAddress = UserDefaults.standard.string(
            forKey: "SelectedAddress"
        ) {
            lblAddress.text = savedAddress
        }
    }

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

    @IBAction func btnChangeAddressClick(_ sender: Any) {
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
        }
    }

    @IBAction func btnSendOrderClick(_ sender: Any) {
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

    func addCard() {
        var newCard = PaymentModel()
        newCard.strCardNumber = txtCardNumber.text
        app.arrCard.append(newCard)

        if let last4 = newCard.strCardNumber?.suffix(4) {
            print("Added card **** **** **** \(last4)")
        }

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
        UIAlertController.showAlert(
            title: "Success",
            message: "Card Added Successfully",
            viewController: self
        )

        DispatchQueue.main.async {
            self.tblCheckOutView.reloadData()
        }
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
    }
    @IBAction func btnBackToHomeClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomeStoryBoard", bundle: nil)
        if let homeVc = storyboard.instantiateViewController(
            withIdentifier: "HomeViewController"
        ) as? HomeViewController {
            self.navigationController?.pushViewController(
                homeVc,
                animated: true
            )
        }

    }

}
