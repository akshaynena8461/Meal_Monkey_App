import UIKit

extension OrderListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app.arrOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        
        cell.configOrderListCell(products: app.arrOrder[indexPath.row],index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MoreStoryBoard", bundle: nil)
        if let myOrdertVc = storyboard.instantiateViewController(
            withIdentifier: "MyOrderViewController"
        ) as? MyOrderViewController {
            myOrdertVc.arrOrderDetail = app.arrOrder[indexPath.row]
            self.navigationController?.pushViewController(
                myOrdertVc,
                animated: true
            )
        }
    }
    
}
