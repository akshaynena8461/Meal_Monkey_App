import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var viewScroll: UIScrollView!
    var arrCard: [PaymentModel] = PaymentModel.addcardDetails()

    @IBOutlet weak var backView: UIView!
    @IBAction func btnAddCardClick(_ sender: Any) {
    }
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

        addCardPageView.layer.shadowColor = UIColor.black.cgColor
        addCardPageView.layer.shadowOpacity = 0.3
        addCardPageView.layer.shadowOffset = CGSize(width: 0, height: -2)
        addCardPageView.layer.shadowRadius = 10

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

    @objc func CartBtnTapped() {
        print("Cart Btn Tapped")
    }

    @objc func BackBtnTapped() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func btnAddAnotherDebitOrCreditCardClick(_ sender: Any) {
        backView.isHidden = false
        tblPaymentView.isHidden = true
        addCardPageView.isHidden = false
        btnAddAnotherDebitOrCreditCard.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.addCardPageView.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
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
