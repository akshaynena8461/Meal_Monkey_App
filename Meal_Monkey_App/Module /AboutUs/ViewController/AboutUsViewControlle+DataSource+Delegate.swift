import UIKit

extension AboutUsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
//        switch objPagetype {
//        case .AboutUs:
//            return arrCurrent.count
//        case .Notification:
//            return arrCurrent.count
//        case .Inbox:
//        default:
//            return 0
//        }
        return arrCurrent.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "AboutUsTableViewCell",
                for: indexPath
            ) as! AboutUsTableViewCell

        switch objPagetype {
        case .AboutUs:
            cell.configaboutcell(about: arrCurrent[indexPath.row])

        case .Notification:
            cell.configNotificationcell(
                about: arrCurrent[indexPath.row]
                
            )
        case .Inbox:
            cell.configInboxcell(about: arrCurrent[indexPath.row])
            
        default:
            return UITableViewCell()
        }

        cell.selectionStyle = .none

        return cell
    }

}
