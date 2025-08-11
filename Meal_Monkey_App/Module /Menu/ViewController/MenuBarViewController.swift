import UIKit

class MenuBarViewController: UIViewController {

    var arrMenuData: [MenuModel] = MenuModel.addMenuData()

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblMenuView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tblMenuView.backgroundColor = .clear
        setLeftAlignedTitle("Menu")
        setCartButton(target: self, action: #selector(openCart))

        tblMenuView.showsVerticalScrollIndicator = false

        EditStyle.setborder(textfields: [txtSearch], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)

        tblMenuView.register(
            UINib(nibName: "MenuTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MenuTableViewCell"
        )

    }
    @objc func openCart() {
        print("Cart Page")
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
    @objc func menuBtnTapped() {
        print("Menu Btn")
    }

}
