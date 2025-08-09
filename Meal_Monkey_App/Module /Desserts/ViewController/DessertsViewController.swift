

import UIKit

class DessertsViewController: UIViewController {

   

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblDessertsView: UITableView!
    
    var selectedProductType: ProductType = .Desserts
    
    var arrProducts: [DessertsModel] {
        switch selectedProductType {
        case .food:
            return DessertsModel.addFoodData()
        case .Desserts:
            return DessertsModel.addDessertsData()
        case .Beverages:
            return DessertsModel.addBeveragesData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        EditStyle.setborder(textfields: [txtSearch], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)

        tblDessertsView.showsVerticalScrollIndicator = false

        switch selectedProductType {
        case .food:
            setLeftAlignedTitleWithBack(
                "Food",
                target: self,
                action: #selector(BackBtnTapped)
            )

        case .Beverages:
            setLeftAlignedTitleWithBack(
                "Beverages",
                target: self,
                action: #selector(BackBtnTapped)
            )

        case .Desserts:
            setLeftAlignedTitleWithBack(
                "Desserts",
                target: self,
                action: #selector(BackBtnTapped)
            )

        }

        setCartButton(target: self, action: #selector(CartBtnTapped))

        tblDessertsView.register(
            UINib(nibName: "DessertsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "DessertsTableViewCell"
        )

    }
    @objc func CartBtnTapped() {
        print("CartBtnTapped")
    }
    @objc func BackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}
