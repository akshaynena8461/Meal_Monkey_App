import UIKit

extension CartViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        // Return number of items in the cart
        return app.arrCart.count
    }

    // MARK: - Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

        // Dequeue reusable CartTableViewCell
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "CartTableViewCell",
                for: indexPath
            ) as! CartTableViewCell

        // Configure the cell with the product and specify it as a cart type
        cell.configCell(product: app.arrCart[indexPath.row], type: .cart)

        // MARK: - Delete action callback
        cell.onDelete = {

            // Fetch the current logged-in user
            if let email = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            ),
                let user = CoreDataManager.shared.fetchUserbyEmail(
                    byEmail: email
                )
            {
                // ⚠️ Potential issue:
                // Using `self.products?.intId ?? 1` may not delete the correct product
                // It should reference the product at this indexPath:
                let product = app.arrCart[indexPath.row]
                let productIdToRemove = app.arrCart[indexPath.row].intId
                CoreDataManager.shared.removeFromCart(
                    for: user,
                    productId: productIdToRemove
                )
                CartManager.shared.remove(quantity: product.intProductQty ?? 0)
                // Optional: clear cart? Usually, removeFromCart should be enough
                // CoreDataManager.shared.clearCart(for: user)  <-- May remove all items accidentally
            }

            // Remove the product from local cart array
            app.arrCart.remove(at: indexPath.row)

            // Update UI: hide/show empty label and place order button
            self.btnPlaceOrder.isHidden = app.arrCart.isEmpty
            self.lblEmpty.isHidden = !app.arrCart.isEmpty

            // Reload table view
            self.tblCartView.reloadData()
        }
        return cell
    }
}
