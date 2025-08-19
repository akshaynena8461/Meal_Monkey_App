import UIKit

extension CheckOutViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Minimum 2 rows: 1 for Cash on Delivery (COD), 1 for UPI
        // Additional rows for saved cards
        if app.arrCard.isEmpty {
            return 2
        }
        return 2 + app.arrCard.count
    }

    // MARK: - Cell for Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Determine total number of rows in the section
        let totalRows = tblCheckOutView.numberOfRows(inSection: indexPath.section)

        switch indexPath.row {
        case 0:
            // First row is always Cash on Delivery
            let cell = tableView.dequeueReusableCell(withIdentifier: "CaseOnDeliveryCell", for: indexPath) as! CaseOnDeliveryCell
            cell.selectionStyle = .none
            return cell

        case totalRows - 1:
            // Last row is always UPI payment
            let cell = tableView.dequeueReusableCell(withIdentifier: "UPIViewCell", for: indexPath) as! UPIViewCell
            cell.selectionStyle = .none
            return cell

        default:
            // Middle rows are saved cards
            let cardIndex = indexPath.row - 1
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardViewCell", for: indexPath) as! CardViewCell
            cell.selectionStyle = .none
            cell.configPaymentCell(payment: app.arrCard[cardIndex])
            return cell
        }
    }

    // MARK: - Optional: Row Height (if needed)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 70         // COD cell height
        case tblCheckOutView.numberOfRows(inSection: indexPath.section) - 1: return 70 // UPI cell height
        default: return 90        // Card cell height
        }
    }
}
