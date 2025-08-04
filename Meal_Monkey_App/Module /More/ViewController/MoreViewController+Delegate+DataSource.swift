
import UIKit

extension MoreViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
        
        cell.configMoreCell(more: arrMore[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)  // Optional: deselect after tap

        switch indexPath.row {
        case 0:
            print("Payment Details selected")

        case 1:
            print("My Orders selected")

        case 2:
            print("Notifications selected")
            // navigationController?.pushViewController(NotificationsVC(), animated: true)

        case 3:
            print("Inbox selected")

        case 4:
            print("About Us selected")

        default:
            break
        }
    }

}
