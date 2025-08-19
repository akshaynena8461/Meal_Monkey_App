import Foundation

// MARK: - MenuModel
class MenuModel {
    // MARK: - Properties
    var strTitle: String?     // Title of the menu item
    var intItem: Int?         // Number of items in this menu category
    var strImage: String?     // Image name for the menu category
    var intTag: Int?          // Tag to identify the menu item (used for indexing or selection)

    // MARK: - Initializer
    init(
        strTitle: String? = nil,
        intItem: Int? = nil,
        strImage: String? = nil,
        intTag: Int? = nil
    ) {
        self.strTitle = strTitle
        self.intItem = intItem
        self.strImage = strImage
        self.intTag = intTag
    }

    // MARK: - Static Helper Method
    /// Returns a predefined array of menu categories
    class func addMenuData() -> [MenuModel] {
        return [
            MenuModel(
                strTitle: "Food",
                intItem: 120,
                strImage: "Food",
                intTag: 0
            ),
            MenuModel(
                strTitle: "Beverages",
                intItem: 220,
                strImage: "Beverages",
                intTag: 1
            ),
            MenuModel(
                strTitle: "Desserts",
                intItem: 155,
                strImage: "Desserts",
                intTag: 2
            ),
        ]
    }
}
