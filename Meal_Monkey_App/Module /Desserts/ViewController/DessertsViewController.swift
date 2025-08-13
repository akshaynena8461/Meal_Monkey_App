import UIKit

class DessertsViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblDessertsView: UITableView!

    @IBOutlet weak var lblNoProduct: UILabel!
    var selectedProductType: ProductType = .Desserts
    
     var filteredProducts: [ProductModel] = []
       private var isSearching = false
    
    var arrProducts: [ProductModel] {
        switch selectedProductType {
        case .food:
            return HomeViewController.arrProductData.filter { $0.objProductType == .food }
        case .Desserts:
            return  HomeViewController.arrProductData.filter { $0.objProductType == .Desserts }
        case .Beverages:
            return  HomeViewController.arrProductData.filter { $0.objProductType == .Beverages }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        lblNoProduct.isHidden = true
        EditStyle.setborder(textfields: [txtSearch], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)

        tblDessertsView.showsVerticalScrollIndicator = false

        txtSearch.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
         
        filteredProducts = arrProducts
        
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
    
    @objc private func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text?.lowercased() ?? ""
        
        if searchText.isEmpty {
            isSearching = false
            filteredProducts = arrProducts
        } else {
            isSearching = true
            filteredProducts = arrProducts.filter { product in
                product.strProductName.lowercased().contains(searchText)
            }
        }
        lblNoProduct.isHidden = !filteredProducts.isEmpty

        
        tblDessertsView.reloadData()
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
