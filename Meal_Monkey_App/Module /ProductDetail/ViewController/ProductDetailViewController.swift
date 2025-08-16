import UIKit

class ProductDetailViewController: UIViewController {

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
    

    var product: ProductModel?
    var quantity: Int = 1
    //    var cartItems: [(product: ProductModel, quantity: Int)] = []

    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    @IBAction func btnHeartClick(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fillStars(for: product?.floatProductRating ?? 0.0, in: stackStars)
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

        if let product = product {
            imgProduct.image = UIImage(named: product.strProductImage)
            lblTitle.text = product.strProductName
            lblDescription.text = product.strProductDescription
            lblPrice.text = "$\(product.doubleProductPrice)"
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
        guard let product = product else { return }
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
        guard let product = product else { return }
        let total = (product.doubleProductPrice) * Double(quantity)
        //        lblPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
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

    func checkProduct(productToAdd: ProductModel) {

        if let existingIndex = app.arrCart.firstIndex(where: {
            $0.intId == productToAdd.intId
        }) {
            app.arrCart[existingIndex].intProductQty =
                quantity + (productToAdd.intProductQty ?? 1)
            print(
                "Updated \(productToAdd.strProductName) quantity to \(quantity)."
            )
        } else {
            let newProduct = productToAdd
            newProduct.intProductQty = quantity
            app.arrCart.append(newProduct)
            print(
                "Added \(productToAdd.strProductName) with quantity \(quantity)."
            )
        }
    }

    @IBAction func btnAddToCartClick(_ sender: Any) {
        guard let product = product else { return }
        checkProduct(productToAdd: product)
        
        UIAlertController.showAlert(
            title: "Success",
            message: "Item Added to Cart",
            viewController: self
        )
    }

    @IBAction func btnPortionClick(_ sender: Any) {
    }

    @IBAction func btnIngredientsClick(_ sender: Any) {
    }
}
