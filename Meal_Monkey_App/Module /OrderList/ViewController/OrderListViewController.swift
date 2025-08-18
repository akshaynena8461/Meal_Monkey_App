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
        if let loggedInUser = CoreDataManager.shared.fetchUserbyEmail(
            byEmail: UserDefaults.standard.string(forKey: "loggedInUserEmail")
                ?? "",
        ) {
            app.arrOrder = CoreDataManager.shared.fetchOrders(for: loggedInUser)
            tblOrderList.reloadData()
            lblEmpty.isHidden = !app.arrOrder.isEmpty
        }
    }

    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
