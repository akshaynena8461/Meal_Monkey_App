import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblMoreView: UITableView!

    var arrMore = MoreModel.addMoreData()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "More"
        
        setLeftAlignedTitle("More")
        setCartButton(target: self, action: #selector(cartButtonTapped))

        let cartButton = UIBarButtonItem(
            image: UIImage(systemName: "cart.fill"),
            style: .plain,
            target: self,
            action: #selector(cartButtonTapped)
        )
        cartButton.tintColor = UIColor(
            red: 74 / 255,
            green: 75 / 255,
            blue: 77 / 255,
            alpha: 1.0
        )

        self.navigationItem.rightBarButtonItem = cartButton

        tblMoreView.register(
            UINib(nibName: "MoreTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MoreTableViewCell"
        )

    }
    @objc func cartButtonTapped() {
        print("Cart button tapped")

    }

}
