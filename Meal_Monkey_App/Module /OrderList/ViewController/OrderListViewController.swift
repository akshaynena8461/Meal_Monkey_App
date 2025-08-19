import UIKit

/// ViewController to display list of orders for the current user
class OrderListViewController: UIViewController {

    @IBOutlet weak var lblEmpty: UILabel!       // Label shown when there are no orders
    @IBOutlet weak var tblOrderList: UITableView! // TableView to show orders

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initially hide the "empty" label
        lblEmpty.isHidden = true
        
        // Show the label if there are no orders
        if app.arrOrder.count == 0 {
            lblEmpty.isHidden = false
        }

        // Set navigation title with back button
        setLeftAlignedTitleWithBack(
            "Order List",
            target: self,
            action: #selector(backBtnTapped)
        )

        // Register custom cell for order list
        tblOrderList.register(
            UINib(nibName: "OrderListTableViewCell", bundle: nil),
            forCellReuseIdentifier: "OrderListTableViewCell"
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Fetch orders for the logged-in user from Core Data
        if let currentUserEmail = UserDefaults.standard.string(forKey: "loggedInUserEmail"),
           let user = CoreDataManager.shared.fetchUserbyEmail(byEmail: currentUserEmail) {
            
            app.arrOrder = CoreDataManager.shared.fetchOrders(for: user)
        }

        // Show/hide empty label depending on whether there are orders
        lblEmpty.isHidden = !app.arrOrder.isEmpty
        
        // Reload table data to reflect any updates
        tblOrderList.reloadData()
    }

    /// Back button action
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
