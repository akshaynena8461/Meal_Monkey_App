import UIKit

class OrderListViewController: UIViewController {

    @IBOutlet weak var tblOrderList: UITableView!
    
    var arrOrder:[OrderModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblOrderList.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrOrder = OrderManager.shared.orders
        tblOrderList.reloadData()
    }

}
