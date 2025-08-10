import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var homeCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var lblCollectionViewTitle: UILabel!

    var collectionType: CollectionType = .category

    override func awakeFromNib() {
        super.awakeFromNib()

        homeCollectionView.register(
            UINib(nibName: "ProductCategoryCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "ProductCategoryCollectionViewCell"
        )
        homeCollectionView.register(
            UINib(nibName: "PopularItemCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "PopularItemCollectionViewCell"
        )
        homeCollectionView.register(
            UINib(nibName: "MostPopularCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MostPopularCollectionViewCell"
        )
        homeCollectionView.register(
            UINib(nibName: "RecentItemCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "RecentItemCollectionViewCell"
        )
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

            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "ProductCategoryCollectionViewCell",
                    for: indexPath
                ) as! ProductCategoryCollectionViewCell
            return cell

        case .popular:
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "PopularItemCollectionViewCell",
                    for: indexPath
                ) as! PopularItemCollectionViewCell
            return cell

        case .mostPopular:
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "MostPopularCollectionViewCell",
                    for: indexPath
                ) as! MostPopularCollectionViewCell
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
            return 10
        case .popular:
            return 5
        case .mostPopular:
            return 5
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
            return CGSize(width: 88, height: 113)
        case .popular:
            return CGSize(width: 375, height: 242)
        case .mostPopular:
            return CGSize(width: 228, height: 185)
        case .RecentItems:
            return CGSize(width: 296, height: 79)
        }
    }
}
enum CollectionType: String {
    case category
    case popular
    case mostPopular
    case RecentItems
}
