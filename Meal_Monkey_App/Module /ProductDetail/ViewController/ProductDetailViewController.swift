import CoreData
import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var detailPageViewinScollView: UIView!
    @IBOutlet weak var stackStars: UIStackView!
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var ProductDetailView: UIView!
    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var stackIngredients: UIStackView!
    @IBOutlet weak var stackPortion: UIStackView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnAddCart: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    let currentUserEmail = UserDefaults.standard.string(
        forKey: "loggedInUserEmail"
    )
    
    var onHeartTapped:(() -> Void)?
    
    
    
    var products: ProductModel?
    var quantity: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillStars(for: products?.floatProductRating ?? 0.0, in: stackStars)
        viewScroll.showsVerticalScrollIndicator = false
        
        EditStyle.setborder(
            textfields: [stackPortion, stackIngredients],
            cornerRadious: 4
        )
        lblCount.text = "\(quantity)"
        btnMinus.isEnabled = false
        configureUI()
        
        setLeftAlignedTitleWithBackInProductDetailPage(
            "",
            target: self,
            action: #selector(backBtnTapped)
        )
        setCartButtonInProuductDetail(
            target: self,
            action: #selector(cartBtnTapped)
        )
        EditStyle.setborder(
            textfields: [btnMinus, btnPlus, lblCount],
            cornerRadious: 15
        )
        lblCount.layer.borderWidth = 1
        lblCount.layer.borderColor = UIColor.systemGray.cgColor
        EditStyle.setborder(textfields: [btnAddCart], cornerRadious: 7.42)
        
        detailPageViewinScollView.layer.cornerRadius = 42
        detailPageViewinScollView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]
        detailPageViewinScollView.clipsToBounds = true
        detailPageViewinScollView.layer.shadowColor = UIColor.black.cgColor
        detailPageViewinScollView.layer.shadowOpacity = 0.3
        detailPageViewinScollView.layer.shadowOffset = CGSize(
            width: 0,
            height: -2
        )
        detailPageViewinScollView.layer.shadowRadius = 30
        
        if let product = products {
            imgProduct.image = UIImage(named: product.strProductImage)
            lblTitle.text = product.strProductName
            lblDescription.text = product.strProductDescription
            lblPrice.text = "$\(product.doubleProductPrice)"
        }
        detailPageViewinScollView.reloadInputViews()
        ProductDetailView.reloadInputViews()
        mainView.reloadInputViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let product = products {
            let isFav = app.arrWishList.contains(where: { $0.intId == product.intId })
            product.objAddFavorite = isFav
            let imageName = isFav ? "heart.fill" : "heart"
            btnHeart.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnHeartClick(_ sender: AnyObject) {
        
        guard let product = self.products,
                let currentUserEmail = currentUserEmail,
                let user = CoreDataManager.shared.fetchUserbyEmail(byEmail: currentUserEmail) else { return }

          if CoreDataManager.shared.isInWishlist(for: user, productId: product.intId) {
              CoreDataManager.shared.removeFromWishlist(for: user, productId: product.intId)
              btnHeart.setImage(UIImage(systemName: "heart"), for: .normal)
          } else {
              CoreDataManager.shared.addToWishlist(for: user, productId: product.intId)
              btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
          }
    }
    
    func updateWishlistData() {
        for item in HomeViewController.arrProductData {
            if app.arrWishList.firstIndex(where: { $0.intId == item.intId }) != nil {
                item.objAddFavorite = true
            } else {
                item.objAddFavorite = false
            }
        }
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
    
    func configureUI() {
        guard let product = products else { return }
        lblTitle.text = product.strProductName
        lblDescription.text = product.strProductDescription
        imgProduct.image = UIImage(named: product.strProductImage)
        lblRatings.text = "\(product.floatProductRating) star Ratings"
        updatePriceAndQuantityUI()
    }
    
    func fillStars(for rating: Float, in stackView: UIStackView) {
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            if let imageView = view as? UIImageView {
                let starIndex = Float(index) + 1.0
                
                if rating >= starIndex {
                    // Full star
                    imageView.image = UIImage(systemName: "star.fill")
                    imageView.tintColor = .systemYellow
                } else if rating + 0.5 >= starIndex {
                    // Half star
                    imageView.image = UIImage(systemName: "star.lefthalf.fill")
                    imageView.tintColor = .systemOrange
                } else {
                    // Empty star
                    imageView.image = UIImage(systemName: "star")
                    imageView.tintColor = .systemGray
                }
            }
        }
    }
    
    func updatePriceAndQuantityUI() {
        guard let product = products else { return }
        let total = (product.doubleProductPrice) * Double(quantity)
        lblTotal.text = "$\(String(format: "%.2f", total))"
        lblCount.text = "\(quantity)"
        btnMinus.isEnabled = quantity > 1
    }
    
    @IBAction func btnPlucClick(_ sender: Any) {
        quantity += 1
        updatePriceAndQuantityUI()
    }
    @IBAction func btnMinusClick(_ sender: Any) {
        if quantity > 1 {
            quantity -= 1
            updatePriceAndQuantityUI()
        }
    }
    
    @IBAction func btnAddToCartClick(_ sender: Any) {
        guard let product = products else { return }
        
        if let currentUserEmail = currentUserEmail,
           let user = CoreDataManager.shared.fetchUserbyEmail(byEmail: currentUserEmail) {
            
            CoreDataManager.shared.addToCart(for: user, product: product, quantity: quantity)
            
            if let index = app.arrCart.firstIndex(where: { $0.intId == product.intId }) {
                app.arrCart[index].intProductQty = (app.arrCart[index].intProductQty ?? 0) + quantity
            } else {
                var newProduct = product
                newProduct.intProductQty = quantity
                app.arrCart.append(newProduct)
            }
            
            UIAlertController.showAlert(
                title: "Success",
                message: "Item Added to Cart",
                viewController: self
            )
        }
    }
    
    @IBAction func btnPortionClick(_ sender: Any) {
    }
    
    @IBAction func btnIngredientsClick(_ sender: Any) {
    }
}
