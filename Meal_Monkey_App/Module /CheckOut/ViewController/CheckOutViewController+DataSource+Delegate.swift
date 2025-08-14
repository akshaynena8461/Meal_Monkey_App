import UIKit

extension CheckOutViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        if app.arrCard.isEmpty {
            return 2
        }
        return 2 + app.arrCard.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let totalRows = tblCheckOutView.numberOfRows(
            inSection: indexPath.section
        )

        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(
                withIdentifier: "CaseOnDeliveryCell",
                for: indexPath
            ) as! CaseOnDeliveryCell

        case totalRows - 1:
            // Last fixed cell (UPI)
            return tableView.dequeueReusableCell(
                withIdentifier: "UPIViewCell",
                for: indexPath
            ) as! UPIViewCell

        default:
            let cardIndex = indexPath.row - 1
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: "CardViewCell",
                    for: indexPath
                ) as! CardViewCell

            cell.selectionStyle = .none
            cell.configPaymentCell(payment: app.arrCard[cardIndex])
            return cell
        }
    }
}
