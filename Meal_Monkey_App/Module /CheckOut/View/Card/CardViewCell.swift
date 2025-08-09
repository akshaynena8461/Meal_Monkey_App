//
//  CardViewCell.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 08/08/25.
//

import UIKit

class CardViewCell: UITableViewCell {

    @IBOutlet weak var stackCard: UIStackView!
    @IBOutlet weak var lblCarNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
