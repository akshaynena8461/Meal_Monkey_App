import UIKit

class CheckOutViewController: UIViewController {

    @IBOutlet weak var btnChangeAddress: UIButton!
    @IBOutlet weak var btnBackToHome: UIButton!
    @IBAction func btnTrackMyOrderClick(_ sender: Any) {
    }
    @IBAction func btnBackToHomeClick(_ sender: Any) {
    }
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

    var arrCards: [String] = ["Card1", "Card2", "Card3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        backView.isHidden = true

        tblCheckOutView.showsVerticalScrollIndicator = false
        thankYouScrollView.showsVerticalScrollIndicator = false
        viewScroll.showsVerticalScrollIndicator = false

        ThankYouPage.isHidden = true
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

        thankYouScrollView.layer.cornerRadius = 20
        thankYouScrollView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]

        thankYouScrollView.layer.shadowColor = UIColor.black.cgColor
        thankYouScrollView.layer.shadowOpacity = 0.3
        thankYouScrollView.layer.shadowOffset = CGSize(width: 0, height: -2)
        thankYouScrollView.layer.shadowRadius = 10

        addCardPageView.layer.cornerRadius = 20
        addCardPageView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]

        ThankYouPage.layer.cornerRadius = 20
        ThankYouPage.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]

        EditStyle.setborder(textfields: [btnSendOrder], cornerRadious: 28)

        addCardPageView.isHidden = true

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

    }

    @IBAction func btnChangeAddressClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryBoard", bundle: nil)
        if let changeAddressVc = storyboard.instantiateViewController(
            withIdentifier: "ChangeAddressViewController"
        ) as? ChangeAddressViewController {
            self.navigationController?.pushViewController(
                changeAddressVc,
                animated: true
            )
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
        }

    }

    @IBAction func btnAddAnotherCardClick(_ sender: Any) {
    }
}
