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
        lblTitle.text = dessert.strProductName
        lblTitle2.attributedText = getStyledText(dessert.strProductDescription)
        lblRating.text = "\(dessert.floatProductRating)"
        imgDessert.image = UIImage(named: dessert.strProductImage)
    }
    
    private func getStyledText(_ text: String) -> NSAttributedString {
           let attributed = NSMutableAttributedString(string: text)
           if let dotRange = text.range(of: "•") {
               let nsRange = NSRange(dotRange, in: text)
               attributed.addAttribute(.foregroundColor, value: UIColor.orange, range: nsRange)
           }
           return attributed
       }

}
