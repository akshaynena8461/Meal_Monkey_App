import UIKit

extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return app.arrWishList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tblWishlist.dequeueReusableCell(
                withIdentifier: "CartTableViewCell",
                for: indexPath
            ) as! CartTableViewCell

        cell.configWishListCell(product: app.arrWishList[indexPath.row])
        cell.onHeartTapped = {

            if let index = app.arrWishList.firstIndex(where: {
                $0.intId == app.arrWishList[indexPath.row].intId
            }) {
                app.arrWishList.remove(at: index)
                self.lblEmpty.isHidden = !app.arrWishList.isEmpty

                self.tblWishlist.reloadData()
            }
        }
        return cell
    }
}
