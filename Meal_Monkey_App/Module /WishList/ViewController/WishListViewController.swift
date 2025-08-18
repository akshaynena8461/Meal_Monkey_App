import UIKit

class WishListViewController: UIViewController {

    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var tblWishlist: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setLeftAlignedTitleWithBack(
            "Wishlist",
            target: self,
            action: #selector(backBtnTapped)
        )

        setCartButton(target: self, action: #selector(cartBtnTapped))

        tblWishlist.register(
            UINib(nibName: "CartTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CartTableViewCell"
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard
            let currentUserEmail = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            ),
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail
            )
        else {
            return
        }

        let wishlistIds = CoreDataManager.shared.fetchWishlistIds(for: user)

        app.arrWishList = HomeViewController.arrProductData.filter {
            wishlistIds.contains($0.intId)
        }

        lblEmpty.isHidden = !app.arrWishList.isEmpty
        tblWishlist.reloadData()
    }

    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
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
}
