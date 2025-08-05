//
//  MenuTableViewCell.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 05/08/25.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var imgRectangle: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblNumberOfItems: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imgArrow: UIImageView!
    //    @IBOutlet weak var btnArrow: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
//    func setCardShadow(view: UIView) {
//        view.layer.cornerRadius = 20
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOpacity = 0.1
//        view.layer.shadowOffset = CGSize(width: 0, height: 4)
//        view.layer.masksToBounds = false
//        view.backgroundColor = .white
//    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
     
    }
    
    func configMenuCell(menu:MenuModel){
        lblName.text = menu.strTitle
        lblNumberOfItems.text = "\(menu.intItem ?? 120) Items"
        imgView.image = UIImage(named: menu.strImage ?? "")
    }
    
}
