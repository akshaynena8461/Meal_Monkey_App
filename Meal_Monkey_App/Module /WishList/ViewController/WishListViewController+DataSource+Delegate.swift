import UIKit

extension WishListViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        // Return the number of products in the wishlist
        return app.arrWishList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        // Dequeue a reusable cell
        let cell =
            tblWishlist.dequeueReusableCell(
                withIdentifier: "CartTableViewCell",
                for: indexPath
            ) as! CartTableViewCell

        // Configure the cell with wishlist product data
        cell.configCell(
            product: app.arrWishList[indexPath.row],
            type: .wishList
        )

        // Handle heart button tap (remove from wishlist)
        cell.onHeartTapped = {
            // Find the index of the tapped product
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
                let productIdToRemove = app.arrWishList[indexPath.row].intId
                CoreDataManager.shared.removeFromWishlist(
                    for: user,
                    productId: productIdToRemove
                )

                // Optional: clear cart? Usually, removeFromCart should be enough
                // CoreDataManager.shared.clearCart(for: user)  <-- May remove all items accidentally
            }
            // Remove product from wishlist array
            app.arrWishList.remove(at: indexPath.row)

            // Show or hide "empty" label based on array count
            self.lblEmpty.isHidden = !app.arrWishList.isEmpty

            // Reload the table view to reflect changes
            self.tblWishlist.reloadData()

        }
        return cell
    }
}
