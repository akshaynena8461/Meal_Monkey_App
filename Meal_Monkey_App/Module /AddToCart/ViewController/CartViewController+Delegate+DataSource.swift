import UIKit

extension CartViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return app.arrCart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "CartTableViewCell",
                for: indexPath
            ) as! CartTableViewCell
            cell.configCartCell(product: app.arrCart[indexPath.row])

        cell.onDelete = { [weak self] in
            guard let self = self,
                let appDelegate =
                    (UIApplication.shared.delegate as? AppDelegate)
            else { return }

            appDelegate.arrCart.remove(at: indexPath.row)
            lblEmpty.isHidden = !app.arrCart.isEmpty
            self.btnPlaceOrder.isHidden = true
            self.tblCartView.reloadData()
        }

        return cell
    }

}
