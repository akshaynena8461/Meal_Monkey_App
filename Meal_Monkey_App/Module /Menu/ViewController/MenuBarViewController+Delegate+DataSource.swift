//
//  MenuViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 05/08/25.
//

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
        case 1:
            print("Bevarages")
        case 2:

            if let dessertvc = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                self.navigationController?.pushViewController(
                    dessertvc,
                    animated: true
                )
            }

        default:
            break
        }

    }

}
