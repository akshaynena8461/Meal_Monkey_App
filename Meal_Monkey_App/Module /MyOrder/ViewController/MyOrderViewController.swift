import UIKit

class MyOrderViewController: UIViewController, ChangeAddressDelegate {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnCheckOut: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lbldeliveryCost: UILabel!
    @IBOutlet weak var lblsubTotal: UILabel!
    @IBOutlet weak var btnAddNotes: UIButton!
    @IBOutlet weak var tblMyOrderView: UITableView!

    var arrOrderDetail: [ProductModel] = []
    let deliveryCost: Double = 5.0

    override func viewDidLoad() {
        super.viewDidLoad()

        tblMyOrderView.showsVerticalScrollIndicator = false

        tblMyOrderView.register(
            UINib(nibName: "MyOrderTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MyOrderTableViewCell"
        )

        setLeftAlignedTitleWithBack(
            "My Order",
            target: self,
            action: #selector(BackBtnTapped)
        )

        EditStyle.setborder(textfields: [btnCheckOut], cornerRadious: 28)

        calculateTotals()
    }
    
    func didSelectAddress(_ address: String) {
        lblAddress.text = address
    }

    func calculateTotals() {
        let subtotal = arrOrderDetail.reduce(0) {
            $0 + ($1.doubleProductPrice * Double($1.intProductQty!))
        }
        lblsubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lbldeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        lblTotal.text = "$\(String(format: "%.2f", subtotal + deliveryCost))"
    }

    @IBAction func btnAddNotesClick(_ sender: Any) {

    }

    @objc func BackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnCheckOutClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryBoard", bundle: nil)
        if let checkoutVc = storyboard.instantiateViewController(
            withIdentifier: "CheckOutViewController"
        ) as? CheckOutViewController {
            checkoutVc.arrCheckOutData = app.arrOrder.flatMap { $0 }
            self.navigationController?.pushViewController(
                checkoutVc,
                animated: true
            )
        }
    }
}
