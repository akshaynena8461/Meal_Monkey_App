import UIKit

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of rows in the table view based on total orders
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app.arrOrder.count
    }

    /// Configures each table view cell with order details
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell of type OrderListTableViewCell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "OrderListTableViewCell",
            for: indexPath
        ) as! OrderListTableViewCell
        
        // Configure the cell with the order's products and its index
        cell.configOrderListCell(
            products: app.arrOrder[indexPath.row],
            index: indexPath.row
        )
        
        // Disable the default cell selection style
        cell.selectionStyle = .none
        return cell
    }
    
    /// Handles cell selection to navigate to the detailed MyOrderViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MoreStoryBoard", bundle: nil)
        
        // Instantiate the MyOrderViewController
        if let myOrderVc = storyboard.instantiateViewController(
            withIdentifier: "MyOrderViewController"
        ) as? MyOrderViewController {
            
            // Pass the selected order's products to MyOrderViewController
            myOrderVc.arrOrderDetail = app.arrOrder[indexPath.row]
            
            // Push the detailed order view onto the navigation stack
            self.navigationController?.pushViewController(
                myOrderVc,
                animated: true
            )
        }
    }
}
