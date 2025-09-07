import CoreData
import NVActivityIndicatorView
import UIKit

class ProductDetailViewController: UIViewController {

    var activityIndicator: NVActivityIndicatorView!

    // MARK: - IBOutlets
    @IBOutlet weak var btnCart: UIButton!
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

    // MARK: - Variables
    let currentUserEmail = UserDefaults.standard.string(
        forKey: "loggedInUserEmail"
    )
    var onHeartTapped: (() -> Void)?  // Callback when heart button is tapped
    var products: ProductModel?  // Current product being displayed
    var quantity: Int = 1  // Current quantity of product for cart

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateCartBadge),
            name: .cartUpdated,
            object: nil
        )

        // Hide product detail UI initially while loading
        ProductDetailView.isHidden = true
        imgProduct.isHidden = true

        MyActivityIndicator()

        self.navigationController?.isNavigationBarHidden = true
        // Simulate a loading delay of 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Show the main content after loading
            self.mainView.isHidden = false
            self.ProductDetailView.isHidden = false
            self.imgProduct.isHidden = false
            self.navigationController?.isNavigationBarHidden = false

            // Setup navigation buttons
            self.setLeftAlignedTitleWithBackInProductDetailPage(
                "",
                target: self,
                action: #selector(self.backBtnTapped)
            )
            self.setCartButtonInProductDetail(
                target: self,
                action: #selector(self.cartBtnTapped)
            )
            self.hideLoader()

        }

        // Fill stars UI based on product rating
        fillStars(for: products?.floatProductRating ?? 0.0, in: stackStars)

        // Hide vertical scroll indicator
        viewScroll.showsVerticalScrollIndicator = false

        // Style ingredient and portion stacks
        EditStyle.setborder(
            textfields: [stackPortion, stackIngredients],
            cornerRadious: 4
        )

        // Initialize quantity label
        lblCount.text = "\(quantity)"
        btnMinus.isEnabled = false  // Can't reduce below 1 initially

        // Configure UI with product data
        configureUI()

        // Style quantity controls
        EditStyle.setborder(
            textfields: [btnMinus, btnPlus, lblCount],
            cornerRadious: 15
        )
        lblCount.layer.borderWidth = 1
        lblCount.layer.borderColor = UIColor.systemGray.cgColor

        // Style "Add to Cart" button
        EditStyle.setborder(textfields: [btnAddCart], cornerRadious: 7.42)

        // Style detail page view with rounded corners and shadow
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

        // Populate product details
        if let product = products {
            imgProduct.image = UIImage(named: product.strProductImage)
            lblTitle.text = product.strProductName
            lblDescription.text = product.strProductDescription
            lblPrice.text = "$\(product.doubleProductPrice)"
        }
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared
        view.backgroundColor = theme.backgroundColor()
        detailPageViewinScollView.backgroundColor = theme.backgroundColor()
        ProductDetailView.backgroundColor = theme.backgroundColor()
        btnAddCart.backgroundColor = theme.primaryButtonBackground()
        btnAddCart.setTitleColor(.white, for: .normal)
        btnPlus.backgroundColor =  theme.primaryButtonBackground()
        btnPlus.backgroundColor = theme.primaryButtonBackground()
        lblRatings.textColor = theme.ratingPointsColor()
        lblDescription.textColor = theme.subTextColor()
        lblTitle.textColor = theme.textColor()
        lblPrice.textColor = theme.textColor()
        lblTotal.textColor = theme.textColor()
        lblCount.backgroundColor = theme.backgroundColor()
        lblCount.textColor = theme.textColor()
        btnMinus.backgroundColor = theme.primaryButtonBackground()
    }

    func MyActivityIndicator() {
        let frame = CGRect(
            x: (view.frame.width - 50) / 2,
            y: (view.frame.height - 50) / 2,
            width: 50,
            height: 50
        )

        activityIndicator = NVActivityIndicatorView(
            frame: frame,
            type: .ballClipRotateMultiple,
            color: UIColor(named: "loginbtnbg"),
            padding: 0
        )
        view.addSubview(activityIndicator)
        showLoader()
    }

    func showLoader() {
        activityIndicator.startAnimating()
    }

    func hideLoader() {
        activityIndicator.stopAnimating()
    }

    @objc private func updateCartBadge() {
        setCartButtonInProductDetail(
            target: self,
            action: #selector(cartBtnTapped),
        )

        let cartCount = CartManager.shared.count
        tabBarController?.tabBar.items?[2].badgeValue =
            cartCount > 0 ? "\(cartCount)" : nil
    }

    // MARK: - Update wishlist heart icon
    override func viewWillAppear(_ animated: Bool) {
        syncWishlistFromCoreData()
        guard let product = products else { return }
        let isFav = app.arrWishList.contains { $0.intId == product.intId }
        product.objAddFavorite = isFav
        let imageName = isFav ? "heart.fill" : "heart"
        btnHeart.setImage(UIImage(systemName: imageName), for: .normal)
        applyTheme()
    }

    func syncWishlistFromCoreData() {
        guard
            let currentUserEmail = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            ),
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail
            )
        else {
            app.arrWishList = []
            return
        }

        let wishlistIds = CoreDataManager.shared.fetchWishlistIds(for: user)

        // Refresh in-memory array from HomeViewController data
        app.arrWishList = HomeViewController.arrProductData.filter {
            wishlistIds.contains($0.intId)
        }
    }

    func updateWishlistData() {
        for item in HomeViewController.arrProductData {
            if app.arrWishList.firstIndex(where: { $0.intId == item.intId })
                != nil
            {
                item.objAddFavorite = true
            } else {
                item.objAddFavorite = false
            }
        }
    }

    // MARK: - Heart button tap
    @IBAction func btnHeartClick(_ sender: AnyObject) {
        guard let product = products,
            let currentUserEmail = currentUserEmail,
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail
            )
        else { return }

        // Toggle wishlist
        if CoreDataManager.shared.isInWishlist(
            for: user,
            productId: product.intId
        ) {
            CoreDataManager.shared.removeFromWishlist(
                for: user,
                productId: product.intId
            )
            btnHeart.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            CoreDataManager.shared.addToWishlist(
                for: user,
                productId: product.intId
            )
            btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }

    // MARK: - Configure product UI
    func configureUI() {
        guard let product = products else { return }
        lblTitle.text = product.strProductName
        lblDescription.text = product.strProductDescription
        imgProduct.image = UIImage(named: product.strProductImage)
        lblRatings.text = "\(product.floatProductRating) star Ratings"
        updatePriceAndQuantityUI()
    }

    // MARK: - Star rating UI
    func fillStars(for rating: Float, in stackView: UIStackView) {
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            guard let imageView = view as? UIImageView else { continue }
            let starIndex = Float(index) + 1

            if rating >= starIndex {
                imageView.image = UIImage(systemName: "star.fill")
                imageView.tintColor = .systemOrange
            } else if rating + 0.5 >= starIndex {
                imageView.image = UIImage(systemName: "star.lefthalf.fill")
                imageView.tintColor = .systemOrange
            } else {
                imageView.image = UIImage(systemName: "star")
                imageView.tintColor = .systemGray
            }
        }
    }

    // MARK: - Update total price and quantity UI
    func updatePriceAndQuantityUI() {
        guard let product = products else { return }
        let total = product.doubleProductPrice * Double(quantity)
        lblTotal.text = "$\(String(format: "%.2f", total))"
        lblCount.text = "\(quantity)"
        btnMinus.isEnabled = quantity > 1
    }

    // MARK: - Quantity controls
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

    @IBAction func btnCartClick(_ sender: Any) {
        let storyboard = UIStoryboard(
            name: Main.StoryBoard.ProductStoryBoard,
            bundle: nil
        )
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.Cart
        ) as? CartViewController {
            navigationController?.pushViewController(cartVc, animated: true)
        }
    }

    // MARK: - Add to cart
    @IBAction func btnAddToCartClick(_ sender: Any) {
        guard let product = products,
            let currentUserEmail = currentUserEmail,
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail
            )
        else { return }

        // Add product to CoreData cart
        CoreDataManager.shared.addToCart(
            for: user,
            product: product,
            quantity: quantity
        )

        CartManager.shared.add(quantity: quantity)

        // Update app-level cart array
        if let index = app.arrCart.firstIndex(where: {
            $0.intId == product.intId
        }) {
            app.arrCart[index].intProductQty =
                (app.arrCart[index].intProductQty ?? 0) + quantity
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

    // MARK: - Navigation
    @objc func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(
            name: Main.StoryBoard.ProductStoryBoard,
            bundle: nil
        )
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.Cart
        ) as? CartViewController {
            navigationController?.pushViewController(cartVc, animated: true)
        }
    }

    // MARK: - Portion & Ingredients (empty actions for future use)
    @IBAction func btnPortionClick(_ sender: Any) {}

    @IBAction func btnIngredientsClick(_ sender: Any) {}
}

extension Notification.Name {
    static let cartUpdated = Notification.Name("cartUpdated")
}
