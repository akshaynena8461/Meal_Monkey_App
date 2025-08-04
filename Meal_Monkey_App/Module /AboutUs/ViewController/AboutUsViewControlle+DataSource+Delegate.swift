import UIKit

extension AboutUsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return arrAboutData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "AboutUsTableViewCell",
                for: indexPath
            ) as! AboutUsTableViewCell

        cell.configaboutcell(about: arrAboutData[indexPath.row])
        cell.selectionStyle = .none

        return cell
    }

}
