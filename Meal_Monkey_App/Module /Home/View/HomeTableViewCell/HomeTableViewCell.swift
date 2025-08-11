import UIKit



class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var homeCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var lblCollectionViewTitle: UILabel!

    var collectionType: CollectionType = .category
    var selectedCategory: ProductCategory = .All

    var categories: [ProductCategory] = [] {
        didSet {
            homeCollectionView.reloadData()
            DispatchQueue.main.async {
                self.homeCollectionView.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }

    func updateCollectionHeight() {
         if let layout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            layout.scrollDirection == .vertical {
             self.homeCollectionViewHeight.constant = self.homeCollectionView.collectionViewLayout.collectionViewContentSize.height
         }
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        registerCells(
            for: homeCollectionView,
            cells: [
                (
                    "ProductCategoryCollectionViewCell",
                    "ProductCategoryCollectionViewCell"
                ),
                (
                    "PopularItemCollectionViewCell",
                    "PopularItemCollectionViewCell"
                ),
                (
                    "MostPopularCollectionViewCell",
                    "MostPopularCollectionViewCell"
                ),
                (
                    "RecentItemCollectionViewCell",
                    "RecentItemCollectionViewCell"
                ),
            ]
        )
    }
    
    func registerCells(
        for collectionView: UICollectionView,
        cells: [(String, String)]
    ) {
        for (nibName, identifier) in cells {
            collectionView.register(
                UINib(nibName: nibName, bundle: nil),
                forCellWithReuseIdentifier: identifier
            )
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnViewAllClick(_ sender: Any) {
    }
}
extension HomeTableViewCell: UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
{
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        switch collectionType {

        case .category:
            let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "ProductCategoryCollectionViewCell",
                    for: indexPath
                ) as! ProductCategoryCollectionViewCell

            cell.confingProductCategory(category: categories[indexPath.row])
            return cell

        case .popular:
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "PopularItemCollectionViewCell",
                    for: indexPath
                ) as! PopularItemCollectionViewCell
            cell.configPopularProduct(product: HomeViewController.arrProductData.filter {
                $0.floatProductRating  > 4 && $0.floatProductRating <= 4.5
            }[indexPath.row] )
            return cell

        case .mostPopular:
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "MostPopularCollectionViewCell",
                    for: indexPath
                ) as! MostPopularCollectionViewCell
            
            cell.congigMostPopularCell(product: HomeViewController.arrProductData.filter {
                $0.floatProductRating > 4.5
            }[indexPath.row])
            return cell

        case .RecentItems:
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "RecentItemCollectionViewCell",
                    for: indexPath
                ) as! RecentItemCollectionViewCell
            return cell

        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch collectionType {
        case .category:
            return categories.count
        case .popular:
            return  HomeViewController.arrProductData.filter {
                $0.floatProductRating  > 4 && $0.floatProductRating <= 4.5}.count
        case .mostPopular:
            return HomeViewController.arrProductData.filter {
                $0.floatProductRating > 4.5
            }.count
        case .RecentItems:
            return 5
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

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
enum CollectionType: String {
    case category
    case popular
    case mostPopular
    case RecentItems
}
