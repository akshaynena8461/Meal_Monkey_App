import UIKit

extension CartViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {

        return app.arrCart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "CartTableViewCell",
                for: indexPath
            ) as! CartTableViewCell

        cell.configCartCell(product: app.arrCart[indexPath.row])
        cell.onDelete = {

            if let email = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            ),
                let user = CoreDataManager.shared.fetchUserbyEmail(
                    byEmail: email
                )
            {

                CoreDataManager.shared.removeFromCart(
                    for: user,
                    productId: self.products?.intId ?? 1
                )
                CoreDataManager.shared.clearCart(for:user)
            }

            app.arrCart.remove(at: indexPath.row)
            self.btnPlaceOrder.isHidden = app.arrCart.isEmpty
            self.lblEmpty.isHidden = !app.arrCart.isEmpty
            self.tblCartView.reloadData()

        }
        return cell
    }
}
