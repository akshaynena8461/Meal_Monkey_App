import UIKit

extension DessertsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        return  filteredProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "DessertsTableViewCell",
                for: indexPath
            ) as! DessertsTableViewCell

        cell.selectionStyle = .none
        cell.configDessertCell(dessert: filteredProducts[indexPath.row])

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        let selectedProduct = filteredProducts[indexPath.row]
        
        RecentItemsHelper.shared.addProduct(selectedProduct)

        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            detailVC.products = selectedProduct
            
            navigationController?.pushViewController(detailVC, animated: true)
        }

    }
}
