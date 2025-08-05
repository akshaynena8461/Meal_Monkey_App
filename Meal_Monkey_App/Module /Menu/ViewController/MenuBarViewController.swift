//
//  MenuViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 05/08/25.
//

import UIKit

class MenuBarViewController: UIViewController {

    var arrMenuData:[MenuModel] = MenuModel.addMenuData()
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblMenuView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMenuView.backgroundColor = .clear
        setLeftAlignedTitle("Menu")
        setCartButton(target: self, action: #selector(openCart))
        
        EditStyle.setborder(textfields: [txtSearch])
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)
        
        tblMenuView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")

    }
    @objc func openCart(){
        print("Cart Page")
    }
    @objc func menuBtnTapped(){
        print("Menu Btn")
    }
    

}
