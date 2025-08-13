import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCartView: UITableView!

    override func viewDidLoad() {

        super.viewDidLoad()

        lblEmpty.isHidden = true
        if app.arrCart.count == 0 {
            lblEmpty.isHidden = false
            btnPlaceOrder.isHidden = true
        }
        setLeftAlignedTitleWithBack(
            "Cart Page",
            target: self,
            action: #selector(backBtnTapped)
        )
        EditStyle.setborder(textfields: [btnPlaceOrder], cornerRadious: 28)

        tblCartView.register(
            UINib(nibName: "CartTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CartTableViewCell"
        )
        tblCartView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        lblEmpty.isHidden = !app.arrCart.isEmpty
        tblCartView.reloadData()
    }

    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnPlaceOrderClick(_ sender: Any) {

        if !app.arrCart.isEmpty {
            app.arrOrder.append(app.arrCart)
            app.arrCart.removeAll()

        }

        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let orderlistVc = storyboard.instantiateViewController(
            withIdentifier: "OrderListViewController"
        ) as? OrderListViewController {
            self.navigationController?.pushViewController(
                orderlistVc,
                animated: true
            )
        }
        lblEmpty.isHidden = false
        btnPlaceOrder.isHidden = true
        tblCartView.reloadData()

    }
}
