

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

}
