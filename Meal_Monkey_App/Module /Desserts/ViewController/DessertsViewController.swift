//
//  DessertsViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 06/08/25.
//

import UIKit

class DessertsViewController: UIViewController {

    var arrDessert: [DessertsModel] = DessertsModel.addDessertsData()

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblDessertsView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        EditStyle.setborder(textfields: [txtSearch],cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)

        tblDessertsView.showsVerticalScrollIndicator = false
        
        
        setLeftAlignedTitleWithBack(
            "Desserts",
            target: self,
            action: #selector(BackBtnTappped)
        )
        setCartButton(target: self, action: #selector(CartBtnTapped))

        tblDessertsView.register(
            UINib(nibName: "DessertsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "DessertsTableViewCell"
        )

    }
    @objc func CartBtnTapped() {
        print("CartBtnTapped")
    }
    @objc func BackBtnTappped() {
        self.navigationController?.popViewController(animated: true)
    }

}
