import UIKit

class AboutUsViewController: UIViewController {

    // MARK: - Properties
    var objPagetype: PageType = .AboutUs
    var arrCurrent: [AboutModel] = []
    
    @IBOutlet weak var tblView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.showsVerticalScrollIndicator = false
        
        NotificationCenter.default.addObserver(
               self,
               selector: #selector(updateCartBadge),
               name: .cartUpdated,
               object: nil
           )
        

        // Register custom cell
        tblView.register(
            UINib(nibName: Main.CellIdentifiers.AboutUsTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifiers.AboutUsTableViewCell
        )

        // Setup navigation bar + page data
        configurePage()
    }

    // MARK: - Page Setup
    private func configurePage() {
        switch objPagetype {
        case .PayMent:
            print("Payment")

        case .MyOrders:
            print("My Orders")

        case .Notification:
            setLeftAlignedTitleWithBack("Notification", target: self, action: #selector(backBtnTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addNotificationData()

        case .Inbox:
            setLeftAlignedTitleWithBack("Inbox", target: self, action: #selector(backBtnTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addInboxData()

        case .AboutUs:
            setLeftAlignedTitleWithBack("About Us", target: self, action: #selector(backBtnTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addAboutData()

        case .WishList:
            print("Wishlist")
        }
    }

    @objc private func updateCartBadge() {
        setCartButton(target: self, action: #selector(cartButtonTapped))
    }
    
    // MARK: - Button Actions
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let cartVc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(cartVc, animated: true)
        }
    }

    @objc func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
}
