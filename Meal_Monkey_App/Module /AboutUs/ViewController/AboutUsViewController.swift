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
            setLeftAlignedTitleWithBack(Main.NavTitle.notification, target: self, action: #selector(backBtnTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addNotificationData()

        case .Inbox:
            setLeftAlignedTitleWithBack(Main.NavTitle.inbox, target: self, action: #selector(backBtnTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addInboxData()

        case .AboutUs:
            setLeftAlignedTitleWithBack(Main.NavTitle.aboutUs, target: self, action: #selector(backBtnTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addAboutData()

        case .WishList:
            print("Wishlist")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurePage()
        applyTheme()
        tblView.reloadData()
    }

    func applyTheme(){
        let theme = ThemeManager.shared
        
        view.backgroundColor = theme.backgroundColor()
        tblView.backgroundColor = theme.backgroundColor()
    }
    
    @objc private func updateCartBadge() {
        setCartButton(target: self, action: #selector(cartButtonTapped))
    }
    
    // MARK: - Button Actions
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: Main.StoryBoard.ProductStoryBoard, bundle: nil)
        if let cartVc = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.Cart) as? CartViewController {
            self.navigationController?.pushViewController(cartVc, animated: true)
        }
    }

    @objc func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
}
