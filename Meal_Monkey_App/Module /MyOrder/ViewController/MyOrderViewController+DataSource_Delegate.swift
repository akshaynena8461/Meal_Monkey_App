import UIKit

extension MyOrderViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - UITableViewDataSource

    /// Returns the number of rows in the table view
    /// Each row represents a product in the order
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOrderDetail.count
    }

    /// Configures and returns the cell for each row
    /// - Parameter indexPath: The index path of the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Dequeue reusable cell as MyOrderTableViewCell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MyOrderTableViewCell",
            for: indexPath
        ) as! MyOrderTableViewCell

        // Remove default selection style
        cell.selectionStyle = .none

        // Configure cell with product details
        cell.configMyOrderDetailCell(product: arrOrderDetail[indexPath.row])

        return cell
    }

    // MARK: - UITableViewDelegate
    // (Optional: add delegate methods here if needed, e.g., didSelectRowAt)
}
