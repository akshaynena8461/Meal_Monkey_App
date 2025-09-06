import Foundation

// MARK: - MoreModel
// This model represents a "More" menu item in the app (like Payment, Orders, Notifications, etc.)
class MoreModel {
    
    // Title of the menu item
    var strTitle: String?
    
    // Image name associated with the menu item
    var strImage: String?
    
    // Optional integer tag to identify the menu item
    var intTag: Int?
    
    // Initializer
    init(strTitle: String? = nil, strImage: String? = nil, intTag: Int? = nil) {
        self.strTitle = strTitle
        self.strImage = strImage
        self.intTag = intTag
    }
    
    // Returns an array of default "More" menu items
    class func addMoreData() -> [MoreModel] {
        return [
            MoreModel(
                strTitle:Main.More.payment,  // Title displayed in the menu
                strImage: "Ic_Payment",       // Icon image for Payment Details
                intTag: 0                      // Unique tag to identify the item
            ),
            MoreModel(
                strTitle: Main.More.myOrders,
                strImage: "Ic_MyOrders",
                intTag: 1
            ),
            MoreModel(
                strTitle: Main.More.notifications,
                strImage: "Ic_Notification",
                intTag: 2
            ),
            MoreModel(
                strTitle: Main.More.inbox,
                strImage: "Ic_inbox",
                intTag: 3
            ),
            MoreModel(
                strTitle: Main.More.aboutUs,
                strImage: "Ic_About",
                intTag: 4
            ),
            MoreModel(
                strTitle: Main.More.wishlist,
                strImage: "Ic_heart_fill",
                intTag: 5
            ),
            MoreModel(
                strTitle: Main.More.changeLanguage,
                strImage: "Ic_Language",
                intTag: 6
            ),
            MoreModel(
                strTitle: Main.More.changeTheme,
                strImage: "Ic_Theme",
                intTag: 7
            ),
        ]
    }
}
