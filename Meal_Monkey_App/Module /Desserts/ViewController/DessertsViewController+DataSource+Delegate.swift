import UIKit

extension DessertsViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the count of filtered products (search results or full list)
        return filteredProducts.count
    }

    // MARK: - Configure Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "DessertsTableViewCell",
            for: indexPath
        ) as! DessertsTableViewCell

        // Disable selection highlight
        cell.selectionStyle = .none

        // Configure the cell with product data
        let dessert = filteredProducts[indexPath.row]
        cell.configDessertCell(dessert: dessert)

        return cell
    }

    // MARK: - Handle Cell Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected product
        let selectedProduct = filteredProducts[indexPath.row]

        // Add the selected product to recent items
        RecentItemsHelper.shared.addProduct(selectedProduct)

        // Instantiate ProductDetailViewController and pass the selected product
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(
            withIdentifier: "ProductDetailViewController"
        ) as? ProductDetailViewController {
            detailVC.products = selectedProduct

            // Navigate to the product detail page
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
