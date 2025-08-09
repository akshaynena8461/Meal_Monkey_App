

import UIKit


class AboutUsViewController: UIViewController {

    var objPagetype: PageType = .AboutUs

    var arrCurrent: [AboutModel] = []

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.showsVerticalScrollIndicator = false

        let cartButton = UIBarButtonItem(
            image: UIImage(systemName: "cart.fill"),
            style: .plain,
            target: self,
            action: #selector(cartButtonTapped)
        )
        cartButton.tintColor = UIColor(
            red: 74 / 255,
            green: 75 / 255,
            blue: 77 / 255,
            alpha: 1.0
        )
        self.navigationItem.rightBarButtonItem = cartButton

        switch objPagetype {

        case .PayMent:
            print("Payment")
        case .MyOrders:
            print("My Orders")
        case .Notification:
            setLeftAlignedTitle("Notification")
            setLeftAlignedTitleWithBack(
                "Notification",
                target: self,
                action: #selector(backBtnTapped)
            )
            setCartButton(target: self, action: #selector(backBtnTapped))
            arrCurrent = AboutModel.addNotificationData()
        case .Inbox:
            setLeftAlignedTitle("Inbox")
            setLeftAlignedTitleWithBack(
                "Inbox",
                target: self,
                action: #selector(backBtnTapped)
            )
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addInboxData()
        case .AboutUs:
            setLeftAlignedTitleWithBack(
                "About Us",
                target: self,
                action: #selector(backBtnTapped)
            )
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addAboutData()
        }

        tblView.register(
            UINib(nibName: "AboutUsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "AboutUsTableViewCell"
        )

    }

    @objc func cartButtonTapped() {
        print("Cart button tapped")

    }

    @objc func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
}
