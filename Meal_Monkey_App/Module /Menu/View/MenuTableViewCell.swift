//
//  MenuTableViewCell.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 05/08/25.
//

import UIKit

// MARK: - MenuTableViewCell
class MenuTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imgRectangle: UIImageView!   // Background or decorative rectangle image
    @IBOutlet weak var mainView: UIView!           // Container view for the cell's content
    @IBOutlet weak var lblNumberOfItems: UILabel!  // Label to show number of items in this menu category
    @IBOutlet weak var lblName: UILabel!           // Label to show the menu category name
    @IBOutlet weak var imgView: UIImageView!       // Image representing the menu category
    @IBOutlet weak var imgArrow: UIImageView!      // Arrow image to indicate navigation or selection

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Additional initialization if needed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure view for selected state if needed
    }

    // MARK: - Configuration Method
    /// Configures the cell with a MenuModel object
    /// - Parameter menu: The menu data used to populate the cell
    func configMenuCell(menu: MenuModel) {
        // Set menu name
        lblName.text = menu.strTitle
        // Set number of items with default fallback value
        lblNumberOfItems.text = "\(menu.intItem ?? 120) Items"
        // Set the menu image
        imgView.image = UIImage(named: menu.strImage ?? "")
    }
}
