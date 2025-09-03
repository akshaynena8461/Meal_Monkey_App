import UIKit

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of rows in the table view based on total orders
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of Orders: \(app.arrOrder.count)")
        return app.arrOrder.count
    }

    /// Configures each table view cell with order details
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderListTableViewCell = tableView.dequeueReusableCell(withIdentifier : Main.CellIdentifiers.OrderListTableViewCell,
            for: indexPath
        ) as! OrderListTableViewCell

        // Each order is an array of ProductModel
        let orderProducts = app.arrOrder[indexPath.row]

        // Configure with array of products
        cell.configOrderListCell(products: orderProducts, index: indexPath.row)

        print("Configuring row: \(indexPath.row), Products count: \(orderProducts.count)")

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100  // or whatever fixed height
    }

    
    /// Handles cell selection to navigate to the detailed MyOrderViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryBoard, bundle: nil)
        
        // Instantiate the MyOrderViewController
        if let myOrderVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.MyOrder
        ) as? MyOrderViewController {
            
            // Pass the selected order's products to MyOrderViewController
            app.arrOrderDetail = app.arrOrder[indexPath.row]
            
            // Push the detailed order view onto the navigation stack
            navigationController?.pushViewController(
                myOrderVc,
                animated: true
            )
        }
    }
}
