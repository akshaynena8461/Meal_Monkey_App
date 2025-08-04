//
//  AboutUsViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 04/08/25.
//

import UIKit

class AboutUsViewController: UIViewController {

    var objPagetype: PageType = .AboutUs

    var arrAboutData = AboutModel.addAboutData()

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        switch objPagetype {
        case .PayMent:
            print("Payment")
        case .MyOrders:
            print("My Orders")
        case .Notification:
            self.title = "Notification"
        case .Inbox:
            self.title = "Inbox"
        case .AboutUs:
            self.title = "About Us"
        }
        
        tblView.register(
            UINib(nibName: "AboutUsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "AboutUsTableViewCell"
        )

    }

}
