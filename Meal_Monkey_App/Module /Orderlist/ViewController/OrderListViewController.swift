import Lottie
import UIKit

/// ViewController to display list of orders for the current user
class OrderListViewController: UIViewController {

    @IBOutlet weak var lblEmpty: UILabel!  // Label shown when there are no orders
    @IBOutlet weak var tblOrderList: UITableView!  // TableView to show orders

    override func viewDidLoad() {
        super.viewDidLoad()

        lblEmpty.isHidden = true

        if app.arrOrder.isEmpty {
            setEmptyBackgroundViewWithLottie(tableView:tblOrderList,animationName: "Empty Order", message: "Orderlist is Empty")
        }

        setLeftAlignedTitleWithBack(
            Main.NavTitle.orderlist,
            target: self,
            action: #selector(backBtnTapped)
        )

        // ⚠️ Use register only if using XIB, not storyboard prototype cell
        tblOrderList.register(
            UINib(
                nibName: Main.CellIdentifiers.OrderListTableViewCell,
                bundle: nil
            ),
            forCellReuseIdentifier: Main.CellIdentifiers.OrderListTableViewCell
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Fetch orders for the logged-in user from Core Data
        if let currentUserEmail = UserDefaults.standard.string(
            forKey: "loggedInUserEmail"
        ),
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail
            )
        {

            app.arrOrder = CoreDataManager.shared.fetchOrders(for: user)
        }
        print("app.arrOrder \(app.arrOrder)")

        // Show/hide empty label depending on whether there are orders
        if app.arrOrder.isEmpty {
            setEmptyBackgroundViewWithLottie(tableView:tblOrderList,animationName: "Empty Order", message: "Orderlist is Empty")
        } else {
            tblOrderList.backgroundView = nil  // 👈 remove empty view
        }
        applyTheme()
        tblOrderList.reloadData()
    }
    
    func applyTheme(){
        let theme = ThemeManager.shared
         
        tblOrderList.backgroundColor = theme.backgroundColor()
        view.backgroundColor = theme.backgroundColor()
    }

    /// Back button action
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
