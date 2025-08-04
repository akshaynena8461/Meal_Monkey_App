//
//  AboutUsTableViewCell.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 04/08/25.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configaboutcell(about: AboutModel) {
        lblTitle.text = about.strText
    }

}
