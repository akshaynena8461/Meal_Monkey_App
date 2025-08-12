import UIKit

class OrderListViewController: UIViewController {

    @IBOutlet weak var tblOrderList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}
