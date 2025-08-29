import UIKit

/// UITableView Delegate & DataSource methods for OffersViewController
extension OffersViewController: UITableViewDelegate, UITableViewDataSource {

    /// Returns the number of rows in the table view
    /// - Parameter tableView: The table view requesting this information
    /// - Parameter section: The section index (we have only one section here)
    /// - Returns: Number of offers in arrOffers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffers.count
    }

    /// Configures and returns the cell for a given row
    /// - Parameter tableView: The table view requesting the cell
    /// - Parameter indexPath: Index path of the cell
    /// - Returns: Configured OffersTableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Main.CellIdentifiers.OffersTableViewCell,
            for: indexPath
        ) as! OffersTableViewCell

        // Disable cell selection highlight
        cell.selectionStyle = .none

        // Configure the cell with offer data
        let offer = arrOffers[indexPath.row]
        cell.configOfferCell(offer: offer)

        return cell
    }
}
