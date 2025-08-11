import UIKit

class DessertsViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblDessertsView: UITableView!

    var selectedProductType: ProductType = .Desserts

    var arrProductData: [ProductModel] = ProductModel.addProductData()

    var arrProducts: [ProductModel] {
        switch selectedProductType {
        case .food:
            return arrProductData.filter { $0.objProductType == .food }
        case .Desserts:
            return arrProductData.filter { $0.objProductType == .Desserts }
        case .Beverages:
            return arrProductData.filter { $0.objProductType == .Beverages }
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
    
    @objc func BackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}
