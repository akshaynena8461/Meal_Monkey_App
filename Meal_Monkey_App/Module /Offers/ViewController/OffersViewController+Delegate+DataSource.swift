import UIKit

extension OffersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        arrOffers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "OffersTableViewCell",
                for: indexPath
            ) as! OffersTableViewCell

        cell.selectionStyle = .none
        cell.configOfferCell(offer: arrOffers[indexPath.row])

        return cell
    }
}
