

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var ProductDetailView: UIView!

    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var stackIngredients: UIStackView!
    @IBOutlet weak var stackPortion: UIStackView!
    
    @IBOutlet weak var lblLKR: UILabel!
    @IBOutlet weak var btnAddCart: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewScroll.showsVerticalScrollIndicator = false
        
        EditStyle.setborder(textfields: [stackPortion,stackIngredients], cornerRadious: 4)
        EditStyle.setborder(textfields: [btnMinus,btnPlus], cornerRadious: 15)
        EditStyle.setborder(textfields: [btnAddCart], cornerRadious: 7.42)
        
        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]

        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.3
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
        
        ProductDetailView.layer.cornerRadius = 20
        ProductDetailView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]
        
        ProductDetailView.layer.shadowColor = UIColor.black.cgColor
        ProductDetailView.layer.shadowOpacity = 0.3
        ProductDetailView.layer.shadowOffset = CGSize(width: 0, height: -2)
        ProductDetailView.layer.shadowRadius = 10
        

    }
    @IBAction func btnPlucClick(_ sender: Any) {
    }
    @IBAction func btnMinusClick(_ sender: Any) {
    }
    @IBAction func btnAddCardClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let carVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                carVc,
                animated: true
            )
        }
    }
    @IBAction func btnPortionClick(_ sender: Any) {
    }
    @IBAction func btnIngredientsClick(_ sender: Any) {
    }
}
