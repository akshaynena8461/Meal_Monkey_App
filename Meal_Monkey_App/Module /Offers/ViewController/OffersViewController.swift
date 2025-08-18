import UIKit

class OffersViewController: UIViewController {

    @IBOutlet weak var btnCheckOffers: UIButton!
    @IBOutlet weak var tblOffersView: UITableView!
    var arrOffers: [OfferModel] = OfferModel.addOffersData()

    override func viewDidLoad() {
        super.viewDidLoad()

        tblOffersView.showsVerticalScrollIndicator = false
        setLeftAlignedTitle("Latest Offers")
        setCartButton(target: self, action: #selector(CartBtnTapped))

        btnCheckOffers.layer.cornerRadius = 7.42

        tblOffersView.register(
            UINib(nibName: "OffersTableViewCell", bundle: nil),
            forCellReuseIdentifier: "OffersTableViewCell"
        )
    }

    @objc func CartBtnTapped() {
        print("Cart Tapped")
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

    @IBAction func btnCheckOffersClick(_ sender: Any) {
    }
}
