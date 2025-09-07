import UIKit

extension CheckOutViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        // Minimum 2 rows: 1 for Cash on Delivery (COD), 1 for UPI
        // Additional rows for saved cards
        if app.arrCard.isEmpty {
            return 2
        }
        return 2 + app.arrCard.count
    }

    // MARK: - Cell for Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

        // Determine total number of rows in the section
        let totalRows = tblCheckOutView.numberOfRows(
            inSection: indexPath.section
        )

        switch indexPath.row {
        case 0:
            // First row is always Cash on Delivery
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: Main.CellIdentifiers.CaseOnDeliveryCell,
                    for: indexPath
                ) as! CaseOnDeliveryCell
            cell.selectionStyle = .none
            let isSelected = selectedPaymentIndex == indexPath.row
            let btnImage = isSelected ? "circle.fill" : "circle"
            cell.btnSelectCaseOnDelivery.setImage(
                UIImage(systemName: btnImage),
                for: .normal
            )
            cell.contentView.backgroundColor = ThemeManager.shared.backgroundColor()
            cell.mainView.backgroundColor = UIColor(named: "ViewlineBgColor")
            return cell

        case totalRows - 1:
            // Last row is always UPI payment
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: Main.CellIdentifiers.UPIViewCell,
                    for: indexPath
                ) as! UPIViewCell
            cell.selectionStyle = .none
            let isSelected = selectedPaymentIndex == indexPath.row
            let btnImage = isSelected ? "circle.fill" : "circle"
            cell.btnSelectUpi.setImage(
                UIImage(systemName: btnImage),
                for: .normal
            )
            cell.contentView.backgroundColor = ThemeManager.shared.backgroundColor()
            cell.mainView.backgroundColor = UIColor(named: "ViewlineBgColor")

            return cell

        default:
            // Middle rows are saved cards
            let cardIndex = indexPath.row - 1
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: Main.CellIdentifiers.CardViewCell,
                    for: indexPath
                ) as! CardViewCell
            cell.selectionStyle = .none
            let isSelected = selectedPaymentIndex == indexPath.row
            let btnImage = isSelected ? "circle.fill" : "circle"
            cell.btnSelectCard.setImage(
                UIImage(systemName: btnImage),
                for: .normal
            )
            cell.configPaymentCell(payment: app.arrCard[cardIndex])
            cell.contentView.backgroundColor = ThemeManager.shared.backgroundColor()
            cell.mainView.backgroundColor = UIColor(named: "ViewlineBgColor")

            return cell
        }
    }
    
    // MARK: - Did Select Row
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        selectedPaymentIndex = indexPath.row
        tblCheckOutView.reloadData()
    }
}
