import UIKit

extension MyOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return arrOrderDetail.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "MyOrderTableViewCell",
                for: indexPath
            ) as! MyOrderTableViewCell

        cell.selectionStyle = .none
        cell.configMyOrderDetailCell(product: arrOrderDetail[indexPath.row])
         return cell
    }

}
