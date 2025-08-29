import UIKit

extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        // Number of saved cards in the app array
        return app.arrCard.count
    }

    // MARK: - Cell Configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {

        // Dequeue a reusable PaymentTableViewCell
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: Main.CellIdentifiers.PaymentTableViewCell,
                for: indexPath
            ) as! PaymentTableViewCell

        // Disable cell selection highlighting
        cell.selectionStyle = .none

        // Configure the delete action closure
        // When delete button is tapped, remove the card from the array, update empty label, and reload table
        cell.configPaymentCell(payment: app.arrCard[indexPath.row])

        cell.onDelete = {

            if let email = UserDefaults.standard.string(
                forKey: "loggedInUserEmail"
            ),
                let user = CoreDataManager.shared.fetchUserbyEmail(
                    byEmail: email
                )
            {
                let cardIdToRemove = app.arrCard[indexPath.row].intCardId
                CoreDataManager.shared.deleteCard(
                    for: user,
                    cardId: cardIdToRemove ?? 0
                )
            }
            app.arrCard.remove(at: indexPath.row)
            self.lblEmpty.isHidden = !app.arrCard.isEmpty
            self.tblPaymentView.reloadData()
        }

        return cell
    }

    // MARK: - Optional: Row Selection (if needed)
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        // Example: Could show card details or allow editing
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
