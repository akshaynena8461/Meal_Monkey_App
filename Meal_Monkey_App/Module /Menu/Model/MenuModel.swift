import Foundation

class MenuModel {
    var strTitle: String?
    var intItem: Int?
    var strImage: String?

    init(strTitle: String? = nil, intItem: Int? = nil, strImage: String? = nil)
    {
        self.strTitle = strTitle
        self.intItem = intItem
        self.strImage = strImage
    }

    class func addMenuData() -> [MenuModel] {
        return [
            MenuModel(strTitle: "Food", intItem: 120,strImage: "Food"),
            MenuModel(strTitle: "Beverages", intItem: 220,strImage: "Beverages"),
            MenuModel(strTitle: "Desserts", intItem: 155,strImage: "Desserts"),
            MenuModel(strTitle: "Promotions", intItem: 25),
        ]
    }
}
