import UIKit

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return arrMore.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "MoreTableViewCell",
                for: indexPath
            ) as! MoreTableViewCell

        cell.configMoreCell(more: arrMore[indexPath.row])
        cell.selectionStyle = .none

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "MoreStoryBoard", bundle: nil)

        
        switch indexPath.row {
        case 0:
            print("Payment Details selected")
            if let paymentvc = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController{
                self.navigationController?.pushViewController(paymentvc, animated: true)
            }

        case 1:
            print("My Orders selected")
            if let myorderVc = storyboard.instantiateViewController(withIdentifier: "MyOrderViewController") as? MyOrderViewController{
                self.navigationController?.pushViewController(myorderVc, animated: true)
            }
        case 2:
            print("Notification selected")
            print("About Us selected")
            if let aboutvc = storyboard.instantiateViewController(
                withIdentifier: "AboutUsViewController"
            ) as? AboutUsViewController {
                aboutvc.objPagetype = .Notification
                self.navigationController?.pushViewController(
                    aboutvc,
                    animated: true
                )
            }

        case 3:
            print("Inbox selected")
            print("About Us selected")
            if let aboutvc = storyboard.instantiateViewController(
                withIdentifier: "AboutUsViewController"
            ) as? AboutUsViewController {
                aboutvc.objPagetype = .Inbox
                self.navigationController?.pushViewController(
                    aboutvc,
                    animated: true
                )
            }

        case 4:
            print("About Us selected")
            if let aboutvc = storyboard.instantiateViewController(
                withIdentifier: "AboutUsViewController"
            ) as? AboutUsViewController {
                self.navigationController?.pushViewController(
                    aboutvc,
                    animated: true
                )
            }

        default:
            break
        }
    }

}
enum PageType {
    case PayMent
    case MyOrders
    case Notification
    case Inbox
    case AboutUs
}
