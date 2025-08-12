import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCartView: UITableView!


    override func viewDidLoad() {

        super.viewDidLoad()

        if app.arrCart.count == 0 {
            lblEmpty.isHidden = false
            btnPlaceOrder.isHidden = true
        }
        
        setLeftAlignedTitleWithBack("Cart Page", target: self, action: #selector(backBtnTapped))
        EditStyle.setborder(textfields: [btnPlaceOrder], cornerRadious: 28)

        tblCartView.register(
            UINib(nibName: "CartTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CartTableViewCell"
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tblCartView.reloadData()
    }

     @objc func backBtnTapped() {
         self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func btnPlaceOrderClick(_ sender: Any) {

    }
}
