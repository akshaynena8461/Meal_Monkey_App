import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "HomeTableViewCell",
                for: indexPath
            ) as! HomeTableViewCell

        if let layout = cell.homeCollectionView.collectionViewLayout
            as? UICollectionViewFlowLayout
        {
            layout.scrollDirection =
                (indexPath.row == 0) || (indexPath.row == 2)
                ? .horizontal : .vertical
        }

        switch indexPath.row {
        case 0:
            cell.collectionType = .category
            cell.selectedCategory = selectedCategory
            cell.lblCollectionViewTitle.isHidden = true
            cell.btnViewAll.isHidden = true
            cell.homeCollectionView.layoutIfNeeded()
            cell.categories = ProductCategory.allCases
            cell.homeCollectionViewHeight.constant =
                cell.homeCollectionView.collectionViewLayout
                .collectionViewContentSize.height
        case 1:
            cell.collectionType = .popular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.homeCollectionViewHeight.constant =
                cell.homeCollectionView.collectionViewLayout
                .collectionViewContentSize.height
            cell.lblCollectionViewTitle.text = "Popular"
        case 2:
            cell.collectionType = .mostPopular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.homeCollectionViewHeight.constant = 185
            cell.lblCollectionViewTitle.text = "Most Popular"
        case 3:
            cell.collectionType = .RecentItems
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.homeCollectionViewHeight.constant =
                cell.homeCollectionView.collectionViewLayout
                .collectionViewContentSize.height
            cell.lblCollectionViewTitle.text = "Recent Items"

        default:
            break

        }

        cell.homeCollectionView.reloadData()
        return cell
    }

}
