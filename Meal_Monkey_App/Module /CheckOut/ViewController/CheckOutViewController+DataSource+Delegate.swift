import UIKit

extension CheckOutViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return 5
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(
                withIdentifier: "CaseOnDeliveryCell",
                for: indexPath
            ) as! CaseOnDeliveryCell

        case 1, 2, 3:
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: "CardViewCell",
                    for: indexPath
                ) as! CardViewCell
            let cardIndex = indexPath.row - 1
            if cardIndex < arrCards.count {
                cell.lblCarNumber.text = arrCards[cardIndex]
            }
            return cell

        case 4:
            return tableView.dequeueReusableCell(
                withIdentifier: "UPIViewCell",
                for: indexPath
            ) as! UPIViewCell

        default:
            return UITableViewCell()
        }
    }
}
