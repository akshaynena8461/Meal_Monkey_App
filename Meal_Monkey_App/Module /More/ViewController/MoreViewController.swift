//
//  MoreViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 04/08/25.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblMoreView: UITableView!

    var arrMore = MoreModel.addMoreData()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblMoreView.register(
            UINib(nibName: "MoreTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MoreTableViewCell"
        )
    
    }

   
}
