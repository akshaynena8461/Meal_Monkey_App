//
//  AboutUsTableViewCell.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 04/08/25.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {


    @IBOutlet weak var lblRightTitleWidth: NSLayoutConstraint!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblRightsideTitle: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func btnStarClick(_ sender: Any) {
    }
    
    @IBOutlet weak var imgDotRightConstraint: NSLayoutConstraint!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configaboutcell(about: AboutModel) {
        lblTitle.text = about.strText
        lblTitle2.isHidden = true
        lblRightsideTitle.isHidden = true
        btnStar.isHidden = true
        lblRightTitleWidth.constant = 0
    }

    func configNotificationcell(about: AboutModel) {
        lblTitle.text = about.strText
        btnStar.isHidden = true
        lblRightsideTitle.isHidden = true
        lblTitle2.text = about.strTimezone
        imgDotRightConstraint.constant = 35
    }
    
    func configInboxcell(about: AboutModel) {
        lblTitle.text = about.strText
        btnStar.isHidden = false
        lblRightsideTitle.text = about.strRightSideText
        lblTitle2.text = about.strText2
    }
    
}
