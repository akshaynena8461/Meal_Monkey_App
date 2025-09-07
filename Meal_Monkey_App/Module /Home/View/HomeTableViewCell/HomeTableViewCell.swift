import UIKit

// Delegate to notify parent controller of product or category selection
protocol HomeTableViewCellDelegate: AnyObject {
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectProduct product: ProductModel)
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory)
}

class HomeTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var homeCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var lblCollectionViewTitle: UILabel!
    var selectedIndex: Int = 0


    // MARK: - Properties
    weak var delegate: HomeTableViewCellDelegate?

    var collectionType: CollectionType = .category
    var selectedCategory: ProductCategory = .All

    // Categories array for .category type
    var categories: [ProductCategory] = [] {
        didSet {
            // Reload collection view and update height when categories change
            homeCollectionView.reloadData()
            DispatchQueue.main.async {
                self.homeCollectionView.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }

    // Products array for other types
    var arrProducts: [ProductModel] = [] {
        didSet {
            homeCollectionView.reloadData()
            DispatchQueue.main.async {
                self.homeCollectionView.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        homeCollectionView.delegate = self

        // Register different collection view cells
        registerCells(
            for: homeCollectionView,
            cells: [
                (Main.CellIdentifiers.ProductCategoryCollectionViewCell,Main.CellIdentifiers.ProductCategoryCollectionViewCell),
                (Main.CellIdentifiers.PopularItemCollectionViewCell,Main.CellIdentifiers.PopularItemCollectionViewCell),
                (Main.CellIdentifiers.MostPopularCollectionViewCell,Main.CellIdentifiers.MostPopularCollectionViewCell),
                (Main.CellIdentifiers.RecentItemCollectionViewCell,Main.CellIdentifiers.RecentItemCollectionViewCell)
            ]
        )
    }

    // MARK: - Helper Methods

    // Registers multiple collection view cells efficiently
    func registerCells(for collectionView: UICollectionView, cells: [(String, String)]) {
        for (nibName, identifier) in cells {
            collectionView.register(
                UINib(nibName: nibName, bundle: nil),
                forCellWithReuseIdentifier: identifier
            )
        }
    }

    // Update collection view height dynamically (only for vertical layouts)
    func updateCollectionHeight() {
        if let layout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout,
           layout.scrollDirection == .vertical {
            self.homeCollectionViewHeight.constant =
                self.homeCollectionView.collectionViewLayout.collectionViewContentSize.height
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Actions
    @IBAction func btnViewAllClick(_ sender: Any) {
        // Implement view all action if needed
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension HomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return count based on collection type
        switch collectionType {
        case .category:
            return categories.count
        default:
            return arrProducts.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionType {

        case .category:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Main.CellIdentifiers.ProductCategoryCollectionViewCell,
                for: indexPath
            ) as! ProductCategoryCollectionViewCell
            cell.confingProductCategory(category: categories[indexPath.row])
            if selectedIndex == indexPath.item{
                cell.lblCategoryName.textColor = .systemOrange
            }
            else{
                cell.lblCategoryName.textColor = .darkGray
            }
            let theme = ThemeManager.shared
            cell.backgroundColor = theme.backgroundColor()
            return cell

        case .popular:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Main.CellIdentifiers.PopularItemCollectionViewCell,
                for: indexPath
            ) as! PopularItemCollectionViewCell
            cell.configPopularProduct(product: arrProducts[indexPath.row])
            let theme = ThemeManager.shared
            cell.backgroundColor = theme.backgroundColor()
            return cell

        case .mostPopular:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Main.CellIdentifiers.MostPopularCollectionViewCell,
                for: indexPath
            ) as! MostPopularCollectionViewCell
            cell.congigMostPopularCell(product: arrProducts[indexPath.row])
            let theme = ThemeManager.shared
            cell.backgroundColor = theme.backgroundColor()
            return cell

        case .RecentItems:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Main.CellIdentifiers.RecentItemCollectionViewCell,
                for: indexPath
            ) as! RecentItemCollectionViewCell
            cell.configureRecentItemCell(recentItem: arrProducts[indexPath.row])
            let theme = ThemeManager.shared
            cell.backgroundColor = theme.backgroundColor()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Notify delegate based on type
        switch collectionType {
        case .category:
            let selectedCategory = categories[indexPath.row]
            selectedIndex = indexPath.item
            delegate?.HomeTableViewCell(self, didSelectCategory: selectedCategory)
        default:
            let selectedProduct = arrProducts[indexPath.row]
            delegate?.HomeTableViewCell(self, didSelectProduct: selectedProduct)
        }
    }

    // Set item size based on collection type
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionType {
        case .category:
            return CGSize(width: 98, height: 113)
        case .popular:
            return CGSize(width: collectionView.frame.size.width, height: 243)
        case .mostPopular:
            return CGSize(width: 228, height: 185)
        case .RecentItems:
            return CGSize(width: collectionView.frame.size.width, height: 79)
        }
    }
}

// MARK: - Collection Type Enum
enum CollectionType: String {
    case category
    case popular
    case mostPopular
    case RecentItems
}
