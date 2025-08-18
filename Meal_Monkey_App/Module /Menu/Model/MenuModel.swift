import Foundation

class MenuModel {
    var strTitle: String?
    var intItem: Int?
    var strImage: String?
    var intTag: Int?

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
