import UIKit

class OrderListViewController: UIViewController {

    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var tblOrderList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        lblEmpty.isHidden = true
        if app.arrOrder.count == 0 {
            lblEmpty.isHidden = false

        }

        setLeftAlignedTitleWithBack(
            "Order List",
            target: self,
            action: #selector(backBtnTapped)
        )
        tblOrderList.register(
            UINib(nibName: "OrderListTableViewCell", bundle: nil),
            forCellReuseIdentifier: "OrderListTableViewCell"
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let currentUserEmail = UserDefaults.standard.string(forKey: "loggedInUserEmail"),
           let user = CoreDataManager.shared.fetchUserbyEmail(byEmail: currentUserEmail) {
            
            app.arrOrder = CoreDataManager.shared.fetchOrders(for: user)
        }

        lblEmpty.isHidden = !app.arrOrder.isEmpty
        tblOrderList.reloadData()
    }

    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
