//
//  DessertsViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 06/08/25.
//

import UIKit

extension DessertsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        arrDessert.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "DessertsTableViewCell",
                for: indexPath
            ) as! DessertsTableViewCell

        cell.selectionStyle = .none
        cell.configDessertCell(dessert: arrDessert[indexPath.row])

        return cell

    }

}
