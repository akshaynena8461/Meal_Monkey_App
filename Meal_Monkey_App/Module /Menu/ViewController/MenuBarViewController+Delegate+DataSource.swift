import UIKit

// MARK: - UITableView Delegate & DataSource
extension MenuBarViewController: UITableViewDelegate, UITableViewDataSource {

    // Returns the number of rows in the table view (equal to the menu items count)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return filteredMenuData.count
    }

    // Configures each table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {

        // Dequeue a reusable MenuTableViewCell
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "MenuTableViewCell",
                for: indexPath
            ) as! MenuTableViewCell

        // Set cell styling
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none

        // Configure cell with menu data
        cell.configMenuCell(menu: filteredMenuData[indexPath.row])

        return cell
    }

    // Handles what happens when a table view row is selected
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let storyboard = UIStoryboard(name: "MenuStoryBoard", bundle: nil)

        // Get the selected menu item
        let selectedItemTag = filteredMenuData[indexPath.row].intTag

        switch selectedItemTag {

        case 0:  // Food category
            print("Food")
            if let foodVC = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                foodVC.selectedProductType = .food
                self.navigationController?.pushViewController(
                    foodVC,
                    animated: true
                )
            }

        case 1:  // Beverages category
            print("Beverages")
            if let beveragesVC = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                beveragesVC.selectedProductType = .Beverages
                self.navigationController?.pushViewController(
                    beveragesVC,
                    animated: true
                )
            }

        case 2:  // Desserts category
            print("Desserts")
            if let dessertVC = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                dessertVC.selectedProductType = .Desserts
                self.navigationController?.pushViewController(
                    dessertVC,
                    animated: true
                )
            }

        default:
            break
        }
    }

    // MARK: - Navigation button actions

    /// Placeholder for cart button tap
    @objc func CartBtnTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)

        // Instantiate CartViewController and push it onto the navigation stack
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                cartVc,
                animated: true
            )
        }
    }

    /// Go back to previous screen
    @objc func BackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
