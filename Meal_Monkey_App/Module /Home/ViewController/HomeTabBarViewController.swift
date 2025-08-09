

import UIKit

class HomeTabBarViewController: UIViewController {

    var arrPopularProducts : [ProductModel] = []
    var arrMostPopularProducts: [ProductModel] = []
    
    var arrProductData:[ProductModel] = ProductModel.addProductData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrPopularProducts = arrProductData.filter{$0.floatProductRating == 4.5}
        arrMostPopularProducts = arrProductData.filter{$0.floatProductRating == 5}

    }


}
