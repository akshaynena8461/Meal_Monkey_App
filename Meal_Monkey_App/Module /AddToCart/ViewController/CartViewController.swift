import CoreData
import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCartView: UITableView!

    var products: ProductModel?

    override func viewDidLoad() {

        super.viewDidLoad()

        if app.arrCart.count == 0 {
            lblEmpty.isHidden = false
            btnPlaceOrder.isHidden = true
        } else {
            lblEmpty.isHidden = true
            btnPlaceOrder.isHidden = false
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
        updateWishlistData()
        if let loggedInUser = CoreDataManager.shared.fetchUserbyEmail(
            byEmail: UserDefaults.standard.string(forKey: "loggedInUserEmail")
                ?? "",
        ) {
            app.arrCart = CoreDataManager.shared.fetchCart(for: loggedInUser)
            tblCartView.reloadData()
            lblEmpty.isHidden = !app.arrCart.isEmpty
        }
    }

    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    func updateWishlistData() {
        for item in HomeViewController.arrProductData {
            if app.arrWishList.firstIndex(where: { $0.intId == item.intId })
                != nil
            {
                item.objAddFavorite = true
            } else {
                item.objAddFavorite = false
            }
        }
    }

    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                cartVc,
                animated: true
            )
        }
    }

    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        guard
            let currentUserEmail = UserDefaults.standard.string(forKey: "loggedInUserEmail"),
            let user = CoreDataManager.shared.fetchUserbyEmail(byEmail: currentUserEmail)
        else {
            print("No logged in user found")
            return
        }
        
        if !app.arrCart.isEmpty {
            // ✅ Save order to Core Data
            CoreDataManager.shared.saveOrder(for: user, products: app.arrCart)
            
            // Clear cart
            CoreDataManager.shared.clearCart(for: user)
            app.arrCart.removeAll()
        }
        
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let orderlistVc = storyboard.instantiateViewController(
            withIdentifier: "OrderListViewController"
        ) as? OrderListViewController {
            self.navigationController?.pushViewController(orderlistVc, animated: true)
        }
        
        lblEmpty.isHidden = false
        btnPlaceOrder.isHidden = true
        tblCartView.reloadData()
    }
}
