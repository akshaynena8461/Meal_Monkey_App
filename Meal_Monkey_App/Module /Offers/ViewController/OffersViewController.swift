
import UIKit

class OffersViewController: UIViewController {

    @IBOutlet weak var btnCheckOffers: UIButton!
    var arrOffers: [OfferModel] = OfferModel.addOffersData()

    @IBOutlet weak var tblOffersView: UITableView!

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
    }
    
    @IBAction func btnCheckOffersClick(_ sender: Any) {
    }
}
