
//
//  MenuViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 05/08/25.
//

import UIKit

extension MenuBarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        cell.configMenuCell(menu: arrMenuData[indexPath.row])
        
        return cell
        
    }
    

   

}
