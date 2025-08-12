import UIKit

extension DessertsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return  HomeViewController.arrProductData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "DessertsTableViewCell",
                for: indexPath
            ) as! DessertsTableViewCell

        cell.selectionStyle = .none

        cell.configDessertCell(dessert:  HomeViewController.arrProductData[indexPath.row])

        return cell

    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        let selectedProduct = HomeViewController.arrProductData[indexPath.row]
        
        RecentItemsHelper.shared.addProduct(selectedProduct)

        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            detailVC.product = selectedProduct
            
            navigationController?.pushViewController(detailVC, animated: true)
        }

    }

}
