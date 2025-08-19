import UIKit

// MARK: - UITableView Delegate & DataSource for AboutUsViewController
extension AboutUsViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of rows in the table (based on arrCurrent data)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCurrent.count
    }

    /// Configures and returns a cell for the given row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Reuse cell from storyboard/XIB
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "AboutUsTableViewCell",
            for: indexPath
        ) as! AboutUsTableViewCell

        // Configure cell UI depending on which page type is active
        switch objPagetype {
        case .AboutUs:
            // Show About Us data
            cell.configaboutcell(about: arrCurrent[indexPath.row])

        case .Notification:
            // Show Notification data
            cell.configNotificationcell(about: arrCurrent[indexPath.row])

        case .Inbox:
            // Show Inbox data
            cell.configInboxcell(about: arrCurrent[indexPath.row])

        default:
            // Fallback (shouldn’t normally happen)
            return UITableViewCell()
        }

        // Disable selection highlight
        cell.selectionStyle = .none

        return cell
    }
}
