import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "HomeTableViewCell",
                for: indexPath
            ) as! HomeTableViewCell

        cell.delegate = self
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
            cell.homeCollectionViewHeight.constant = 113
            cell.categories = ProductCategory.allCases

        case 1:
            cell.collectionType = .popular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = "Popular"

            cell.arrProducts = HomeViewController.arrProductData.filter {
                let matchesRating =
                    $0.floatProductRating >= 4 && $0.floatProductRating <= 4.5
                let matchesCategory =
                    (selectedCategory == .All)
                    || ($0.objProductCategory == selectedCategory)
                let matchesSearch =
                    searchText.isEmpty
                    || $0.strProductName.lowercased().contains(searchText)
                return matchesRating && matchesCategory && matchesSearch
            }

            cell.homeCollectionViewHeight.constant =
                cell.homeCollectionView.collectionViewLayout
                .collectionViewContentSize.height

        case 2:
            cell.collectionType = .mostPopular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.homeCollectionViewHeight.constant = 185
            cell.lblCollectionViewTitle.text = "Most Popular"

            cell.arrProducts = HomeViewController.arrProductData.filter {
                let matchesRating = $0.floatProductRating > 4.5
                let matchesCategory =
                    (selectedCategory == .All)
                    || ($0.objProductCategory == selectedCategory)
                let matchesSearch =
                    searchText.isEmpty
                    || $0.strProductName.lowercased().contains(searchText)
                return matchesRating && matchesCategory && matchesSearch
            }

        case 3:
            cell.collectionType = .RecentItems
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.arrProducts = arrRecentItem
            cell.lblCollectionViewTitle.text = "Recent Items"
            cell.homeCollectionViewHeight.constant =
                cell.homeCollectionView.collectionViewLayout
                .collectionViewContentSize.height

            cell.arrProducts = arrRecentItem.filter {
                let matchesCategory =
                    (selectedCategory == .All)
                    || ($0.objProductCategory == selectedCategory)
                let matchesSearch =
                    searchText.isEmpty
                    || $0.strProductName.lowercased().contains(searchText)
                return matchesCategory && matchesSearch
            }
        default:
            break
        }
        cell.homeCollectionView.reloadData()
        return cell
    }
}
