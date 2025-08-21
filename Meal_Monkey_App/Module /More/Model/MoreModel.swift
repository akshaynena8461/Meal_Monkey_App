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
                strTitle: "Payment Details",  // Title displayed in the menu
                strImage: "Ic_Payment",       // Icon image for Payment Details
                intTag: 0                      // Unique tag to identify the item
            ),
            MoreModel(
                strTitle: "My Orders",
                strImage: "Ic_MyOrders",
                intTag: 1
            ),
            MoreModel(
                strTitle: "Notifications",
                strImage: "Ic_Notification",
                intTag: 2
            ),
            MoreModel(
                strTitle: "Inbox",
                strImage: "Ic_inbox",
                intTag: 3
            ),
            MoreModel(
                strTitle: "About Us",
                strImage: "Ic_About",
                intTag: 4
            ),
            MoreModel(
                strTitle: "Wishlist",
                strImage: "Ic_heart_fill",
                intTag: 5
            ),
        ]
    }
}
