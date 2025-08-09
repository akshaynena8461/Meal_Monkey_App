

import UIKit

class MyOrderViewController: UIViewController {

    @IBOutlet weak var btnCheckOut: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lbldeliveryCost: UILabel!
    @IBOutlet weak var lblsubTotal: UILabel!
    @IBOutlet weak var btnAddNotes: UIButton!
    @IBOutlet weak var tblMyOrderView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("My Order", target: self, action: #selector(BackBtnTapped))
        EditStyle.setborder(textfields: [btnCheckOut], cornerRadious: 28)

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
            self.navigationController?.pushViewController(
                checkoutVc,
                animated: true
            )
        }
    }

}
