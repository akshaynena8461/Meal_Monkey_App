import Foundation

class MoreModel {
    var strTitle: String?
    var strImage: String?

    init(strTitle: String? = nil, strImage: String? = nil) {
        self.strTitle = strTitle
        self.strImage = strImage
    }

    class func addMoreData() -> [MoreModel] {
        return [
            MoreModel(strTitle: "Payment Details", strImage: "Ic_Payment"),
            MoreModel(strTitle: "My Orders", strImage: "Ic_MyOrders"),
            MoreModel(strTitle: "Notifications", strImage: "Ic_Notification"),
            MoreModel(strTitle: "Inbox", strImage: "Ic_inbox"),
            MoreModel(strTitle: "About Us", strImage: "Ic_About"),
        ]
    }
}
