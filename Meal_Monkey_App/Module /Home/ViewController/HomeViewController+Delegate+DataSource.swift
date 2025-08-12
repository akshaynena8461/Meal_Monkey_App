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

            if selectedCategory == .All {
                cell.arrProducts = HomeViewController.arrProductData.filter {
                    $0.floatProductRating >= 4 && $0.floatProductRating <= 4.5
                }
            } else {
                cell.arrProducts = HomeViewController.arrProductData.filter {
                    $0.floatProductRating > 4.5
                        && $0.objProductCategory == selectedCategory
                }
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
            if selectedCategory == .All {
                cell.arrProducts = HomeViewController.arrProductData.filter {
                    $0.floatProductRating > 4.5
                }
            } else {
                cell.arrProducts = HomeViewController.arrProductData.filter {
                    $0.floatProductRating > 4.5
                        && $0.objProductCategory == selectedCategory
                }
            }

        case 3:
            cell.collectionType = .RecentItems
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.homeCollectionViewHeight.constant =
                cell.homeCollectionView.collectionViewLayout
                .collectionViewContentSize.height
            cell.arrProducts = arrRecentItem
            cell.lblCollectionViewTitle.text = "Recent Items"

        default:
            break

        }

        cell.homeCollectionView.reloadData()
        return cell
    }
}
