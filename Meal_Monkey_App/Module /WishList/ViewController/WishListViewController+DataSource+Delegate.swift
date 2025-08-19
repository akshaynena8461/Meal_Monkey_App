import UIKit

extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of products in the wishlist
        return app.arrWishList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell
        let cell = tblWishlist.dequeueReusableCell(
            withIdentifier: "CartTableViewCell",
            for: indexPath
        ) as! CartTableViewCell

        // Configure the cell with wishlist product data
        cell.configCell(product: app.arrWishList[indexPath.row], type: .wishList)
        
        // Handle heart button tap (remove from wishlist)
        cell.onHeartTapped = {
            // Find the index of the tapped product
            if let index = app.arrWishList.firstIndex(where: {
                $0.intId == app.arrWishList[indexPath.row].intId
            }) {
                // Remove product from wishlist array
                app.arrWishList.remove(at: index)
                
                // Show or hide "empty" label based on array count
                self.lblEmpty.isHidden = !app.arrWishList.isEmpty

                // Reload the table view to reflect changes
                self.tblWishlist.reloadData()
            }
        }
        
        return cell
    }
}
