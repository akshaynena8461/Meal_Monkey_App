//
//  DessertsTableViewCell.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 06/08/25.
//

import UIKit

class DessertsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgDessert: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configDessertCell(dessert: DessertsModel) {
        lblTitle.text = dessert.strTitle
        lblTitle2.text = dessert.strTitle2
        lblRating.text = "\(dessert.floatRating ?? 0.0)"
        imgDessert.image = UIImage(named: dessert.strImage ?? "")

    }

}
