//
//  ServiceCollectionViewCell.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 04/08/25.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configServiceCell(imgName: String) {
        imgView.image = UIImage(named: imgName)
    }
    
}
