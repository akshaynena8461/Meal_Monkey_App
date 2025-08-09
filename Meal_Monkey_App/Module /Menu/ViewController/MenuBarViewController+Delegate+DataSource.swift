

import UIKit

extension MenuBarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return arrMenuData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "MenuTableViewCell",
                for: indexPath
            ) as! MenuTableViewCell

        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none

        cell.configMenuCell(menu: arrMenuData[indexPath.row])

        return cell

    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let storyboard = UIStoryboard(
            name: "MenuStoryBoard",
            bundle: nil
        )

        switch indexPath.row {

        case 0:
            print("Food")
            if let foodvc = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                foodvc.selectedProductType = .food
                self.navigationController?.pushViewController(
                    foodvc,
                    animated: true
                )
            }
        case 1:
            print("Beverages")
    
            if let beveragesvc = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                beveragesvc.selectedProductType = .Beverages

                self.navigationController?.pushViewController(
                    beveragesvc,
                    animated: true
                )
            }
        case 2:
           

            if let dessertvc = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                dessertvc.selectedProductType = .Desserts

                self.navigationController?.pushViewController(
                    dessertvc,
                    animated: true
                )
            }

        default:
            break
        }

    }

    @objc func CartBtnTapped() {
        print("Cart Btn Tapped")
    }

    @objc func BackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}

