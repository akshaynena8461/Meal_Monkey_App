
import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCartView: UITableView!
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setLeftAlignedTitle("Cart Page")
        
        EditStyle.setborder(textfields: [btnPlaceOrder], cornerRadious: 28)
        
        tblCartView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")

    }
    
    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        
    }
}
