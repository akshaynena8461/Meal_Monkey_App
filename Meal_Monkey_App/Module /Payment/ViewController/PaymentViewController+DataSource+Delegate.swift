import UIKit

extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        return app.arrCard.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "PaymentTableViewCell",
                for: indexPath
            ) as! PaymentTableViewCell

        cell.selectionStyle = .none

        cell.onDelete = { [weak self] in
            guard let self = self,
                let appDelegate =
                    (UIApplication.shared.delegate as? AppDelegate)
            else { return }

            app.arrCard.remove(at: indexPath.row)
            lblEmpty.isHidden = !app.arrCard.isEmpty
            self.tblPaymentView.reloadData()
        }
        cell.configPaymentCell(payment: app.arrCard[indexPath.row])

        return cell
    }
}
