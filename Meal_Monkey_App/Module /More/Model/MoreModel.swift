import Foundation

class MoreModel {
    var strTitle: String?
    var strImage: String?
    var intTag: Int?

    init(strTitle: String? = nil, strImage: String? = nil, intTag: Int? = nil) {
        self.strTitle = strTitle
        self.strImage = strImage
        self.intTag = intTag
    }

    class func addMoreData() -> [MoreModel] {
        return [
            MoreModel(
                strTitle: "Payment Details",
                strImage: "Ic_Payment",
                intTag: 0
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
                strTitle: "WishList",
                strImage: "Ic_Heart",
                intTag: 5
            ),
        ]
    }
}
