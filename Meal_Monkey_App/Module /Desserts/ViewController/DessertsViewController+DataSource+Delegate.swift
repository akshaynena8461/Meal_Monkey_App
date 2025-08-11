import UIKit

extension DessertsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return arrProducts.count
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

        cell.configDessertCell(dessert: arrProducts[indexPath.row])

        return cell

    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)

        switch indexPath.row {
        case 0:
            if let productvc = storyboard.instantiateViewController(
                withIdentifier: "ProductDetailViewController"
            ) as? ProductDetailViewController {
                self.navigationController?.pushViewController(
                    productvc,
                    animated: true
                )
            }
        default:
            break
        }

    }

}
