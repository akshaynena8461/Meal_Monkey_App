import Foundation

/// A model class that represents different types of content
/// such as About info, Notifications, and Inbox messages.
class AboutModel {

    // MARK: - Properties

    /// Main text content (used in About, Notifications, Inbox titles)
    var strText: String?

    /// Used for showing time-related info (e.g., "5m ago", "1d ago")
    var strTimezone: String?

    /// Used for right-aligned secondary info (e.g., "6th July" in Inbox)
    var strRightSideText: String?

    /// Additional text content (e.g., Inbox message preview)
    var strText2: String?

    // MARK: - Initializer

    /// Initializes a new AboutModel instance with optional values.
    init(
        strText: String? = nil,
        strTimezone: String? = nil,
        strRightSideText: String? = nil,
        strText2: String? = nil
    ) {
        self.strText = strText
        self.strTimezone = strTimezone
        self.strRightSideText = strRightSideText
        self.strText2 = strText2
    }

    // MARK: - Mock Data for "About" Screen

    /// Provides static data for the "About Us" section of the app.
    /// - Returns: Array of `AboutModel` containing descriptive text.
    class func addAboutData() -> [AboutModel] {
        return [
            AboutModel(
                strText: Main.AboutUs.strTxt1
            ),
            AboutModel(
                strText: Main.AboutUs.strTxt2
            ),
            AboutModel(
                strText: Main.AboutUs.strTxt3
            ),
            AboutModel(
                strText: Main.AboutUs.strTxt4
            ),
            AboutModel(
                strText: Main.AboutUs.strTxt5
            ),
            AboutModel(
                strText: Main.AboutUs.strTxt6
            ),
            AboutModel(
                strText: Main.AboutUs.strTxt7
            ),
        ]
    }

    // MARK: - Mock Data for "Notifications" Screen

    /// Provides static data for the notifications list.
    /// Each item contains a message (strText) and a relative time (strTimezone).
    /// - Returns: Array of `AboutModel` representing notifications.
    class func addNotificationData() -> [AboutModel] {
        return [
            AboutModel(
                strText: Main.Notification.notification1,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification2,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification3,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification4,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification5,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification6,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification7,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification8,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification9,
                strTimezone: Main.Notification.notificationTime
            ),

            AboutModel(
                strText: Main.Notification.notification10,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification11,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification12,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification13,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification14,
                strTimezone: Main.Notification.notificationTime
            ),
            AboutModel(
                strText: Main.Notification.notification15,
                strTimezone: Main.Notification.notificationTime
            ),
        ]
    }

    // MARK: - Mock Data for "Inbox" Screen

    /// Provides static data for the inbox messages.
    /// Each item contains a sender/title (strText),
    /// a right-side date (strRightSideText),
    /// and a short message/preview (strText2).
    /// - Returns: Array of `AboutModel` representing inbox messages.
    class func addInboxData() -> [AboutModel] {
        return [
            AboutModel(
                strText: Main.Inbox.inboxTitle1,
                strRightSideText: Main.Inbox.inboxTime,
                strText2: Main.Inbox.inboxMsg1
            ),
            AboutModel(
                strText: Main.Inbox.inboxTitle2,
                strRightSideText: Main.Inbox.inboxTime,
                strText2: Main.Inbox.inboxMsg2
            ),
            AboutModel(
                strText: Main.Inbox.inboxTitle3,
                strRightSideText: Main.Inbox.inboxTime,
                strText2: Main.Inbox.inboxMsg3
            ),
            AboutModel(
                strText: Main.Inbox.inboxTitle4,
                strRightSideText: Main.Inbox.inboxTime,
                strText2: Main.Inbox.inboxMsg4
            ),
            AboutModel(
                strText: Main.Inbox.inboxTitle5,
                strRightSideText: Main.Inbox.inboxTime,
                strText2: Main.Inbox.inboxMsg5
            ),
            AboutModel(
                strText: Main.Inbox.inboxTitle6,
                strRightSideText: Main.Inbox.inboxTime,
                strText2: Main.Inbox.inboxMsg6
            ),
            AboutModel(
                strText: Main.Inbox.inboxTitle7,
                strRightSideText: Main.Inbox.inboxTime,
                strText2: Main.Inbox.inboxMsg7
            ),
            AboutModel(
                strText: Main.Inbox.inboxTitle8,
                strRightSideText: Main.Inbox.inboxTime,
                strText2: Main.Inbox.inboxMsg8
            ),
            AboutModel(
                strText: Main.Inbox.inboxTitle9,
                strRightSideText: Main.Inbox.inboxTime,
                strText2: Main.Inbox.inboxMsg9
            ),
            AboutModel(
                strText: Main.Inbox.inboxTitle10,
                strRightSideText: Main.Inbox.inboxTime,
                strText2: Main.Inbox.inboxMsg10
            ),
        ]
    }
}
