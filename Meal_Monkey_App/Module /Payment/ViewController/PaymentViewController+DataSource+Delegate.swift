//
//  PaymentViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 07/08/25.
//

import UIKit

extension PaymentViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTableViewCell", for: indexPath) as! PaymentTableViewCell
        
        cell.selectionStyle = .none
        
        cell.configPaymentCell(payment: arrCard[indexPath.row])
        
        return cell
    }
    
}
