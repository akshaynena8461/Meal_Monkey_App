import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Number of Rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The table view always has 4 rows for different sections:
        // 0: Categories
        // 1: Popular items
        // 2: Most Popular items
        // 3: Recent items
        return 4
    }

    // MARK: - Configure TableView Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Dequeue reusable HomeTableViewCell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "HomeTableViewCell",
            for: indexPath
        ) as! HomeTableViewCell

        // Set delegate to handle cell interactions
        cell.delegate = self

        // Configure collection view scroll direction based on section
        if let layout = cell.homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            // Horizontal scroll for Categories (0) and Most Popular (2)
            // Vertical scroll for Popular (1) and Recent Items (3)
            layout.scrollDirection = (indexPath.row == 0) || (indexPath.row == 2) ? .horizontal : .vertical
        }

        // Configure cell based on section type
        switch indexPath.row {

        case 0:
            // Categories section
            cell.collectionType = .category
            cell.selectedCategory = selectedCategory
            cell.lblCollectionViewTitle.isHidden = true
            cell.btnViewAll.isHidden = true
            cell.homeCollectionViewHeight.constant = 113
            // Assign all product categories to display
            cell.categories = ProductCategory.allCases

        case 1:
            // Popular items section
            cell.collectionType = .popular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = "Popular"

            // Filter products with rating between 4 and 4.5
            // Also filter by selected category and search text
            cell.arrProducts = HomeViewController.arrProductData.filter {
                let matchesRating = $0.floatProductRating >= 4 && $0.floatProductRating <= 4.5
                let matchesCategory = (selectedCategory == .All) || ($0.objProductCategory == selectedCategory)
                let matchesSearch = searchText.isEmpty || $0.strProductName.lowercased().contains(searchText)
                return matchesRating && matchesCategory && matchesSearch
            }

            // Adjust collection view height based on content
            cell.homeCollectionViewHeight.constant =
                cell.homeCollectionView.collectionViewLayout.collectionViewContentSize.height

        case 2:
            // Most Popular items section
            cell.collectionType = .mostPopular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.homeCollectionViewHeight.constant = 185
            cell.lblCollectionViewTitle.text = "Most Popular"

            // Filter products with rating above 4.5
            // Also filter by selected category and search text
            cell.arrProducts = HomeViewController.arrProductData.filter {
                let matchesRating = $0.floatProductRating > 4.5
                let matchesCategory = (selectedCategory == .All) || ($0.objProductCategory == selectedCategory)
                let matchesSearch = searchText.isEmpty || $0.strProductName.lowercased().contains(searchText)
                return matchesRating && matchesCategory && matchesSearch
            }

        case 3:
            // Recent Items section
            cell.collectionType = .RecentItems
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = "Recent Items"

            // Filter recent items by category and search text
            cell.arrProducts = arrRecentItem.filter {
                let matchesCategory = (selectedCategory == .All) || ($0.objProductCategory == selectedCategory)
                let matchesSearch = searchText.isEmpty || $0.strProductName.lowercased().contains(searchText)
                return matchesCategory && matchesSearch
            }

            // Adjust collection view height based on content
            cell.homeCollectionViewHeight.constant =
                cell.homeCollectionView.collectionViewLayout.collectionViewContentSize.height

        default:
            break
        }

        // Reload collection view inside the table view cell
        cell.homeCollectionView.reloadData()
        return cell
    }
}
