import Foundation

class Main {
    struct CellIdentifiers {
        static let AboutUsTableViewCell = "AboutUsTableViewCell"
        static let CartTableViewCell = "CartTableViewCell"
        static let CardViewCell = "CardViewCell"
        static let CaseOnDeliveryCell = "CaseOnDeliveryCell"
        static let UPIViewCell = "UPIViewCell"
        static let DessertsTableViewCell = "DessertsTableViewCell"
        static let HomeTableViewCell = "HomeTableViewCell"
        static let MenuTableViewCell = "MenuTableViewCell"
        static let MoreTableViewCell = "MoreTableViewCell"
        static let MyOrderTableViewCell = "MyOrderTableViewCell"
        static let OffersTableViewCell = "OffersTableViewCell"
        static let OrderListTableViewCell = "OrderListTableViewCell"
        static let PaymentTableViewCell = "PaymentTableViewCell"
        static let ServiceCollectionViewCell = "ServiceCollectionViewCell"
        static let ProductCategoryCollectionViewCell =
            "ProductCategoryCollectionViewCell"
        static let PopularItemCollectionViewCell =
            "PopularItemCollectionViewCell"
        static let MostPopularCollectionViewCell =
            "MostPopularCollectionViewCell"
        static let RecentItemCollectionViewCell = "RecentItemCollectionViewCell"
    }

    struct Image {
        static let ic_butternaan = "ic_butternaan"
        static let ic_paneertikka = "ic_paneertikka"
        static let ic_hakkanoodles = "ic_hakkanoodles"
        static let Ic_Khaman_Dhokla = "Ic_Khaman_Dhokla"
        static let ic_masaladosa = "ic_masaladosa"
        static let ic_margherita_pizza = "ic_margherita_pizza"
    }

    struct Location {
        static let title = "Location Permission Needed"
        static let message =
            "Please enable location access in Settings to use this feature."
        static let cancel = "Cancel"
        static let settings = "Open Settings"
    }

    //    struct Alert {
    //        static let emptyFieldsTitle = "Missing Info"
    //        static let invalidCredentialmsg = "Invalid Email or Password"
    //        static let fetchFailedMsg = "Something went wrong."
    //        static let fieldsToFillMsg = "Please fill all the fields."
    //        static let nameMissingTitle = "Name Missing"
    //        static let nameMissingMsg = "Please enter your name."
    //        static let emailMissingTitle = "Email Missing"
    //        static let emailMissingMsg = "Please enter your email."
    //        static let emailexistingTitle = "Email Exists"
    //        static let emailexistinMsg = "Email Already Exists"
    //        static let invalidEmailTitle = "Invalid Email"
    //        static let invalidEmailMsg = "Please enter a valid email."
    //        static let adddressMissingTitle = "Address Missing"
    //        static let addressMissingMsg = "Please enter your address."
    //        static let mobileMissingTitle = "Mobile Number Missing"
    //        static let mobileMissingMsg = "Please enter Your Mobile Number"
    //        static let passwordMissingTitle = "Password Missing"
    //        static let passwordMissinMsg = "Please enter your password."
    //        static let invalidPasswordTitle = "Passwords Don't Match"
    //        static let invalidPasswordMsg = "Password must be at least 8 characters, contain uppercase, lowercase, number, and symbol."
    //        static let notMatchPasswordTitle = "Password do not Match"
    //        static let notMatchPasswordMsg = "Password and Confirm Password must be the same."
    //        static let userRegisterSuccessMsg = LanguageManager.shared.localizedString(for: "8461_Alert_user_save")
    //        static let errorTitle = "Error"
    //        static let noLoggedInUser = "No logged-in user found."
    //        static let successTitle =  LanguageManager.shared.localizedString(for: "8461_Alert_success_title")
    //        static let OtpSuccessMsg = "OTP Sent Successfully"
    //        static let cardSuccessMsg = "Card Added Successfully"
    //        static let invalidCard = "Invalid Card"
    //        static let invalidCardMsg =  "Card number must be exactly 16 digits."
    //        static let enterCardNumber = "Please enter a card number."
    //        static let firstName = "Please enter your first name"
    //        static let lastName = "Please enter your last name"
    //        static let errMonth = "Please enter a valid expiry month (01 - 12)"
    //        static let errYear = "Please enter a valid expiry year"
    //        static let cardExpiry = "Card has already expired"
    //        static let errSecurityCode = "Please enter a valid 3-digit security code"
    //        static let invalidMobile = "Please enter a valid 10-digit mobile number"
    //        static let ProfileUpdate = "Profile Updated Successfully"
    //

    //        }

    struct Alert {
        // MARK: - Generic Errors
        static var errorTitle: String {
            LanguageManager.shared.localizedString(for: "8461_error_title")
        }
        static var noLoggedInUser: String {
            LanguageManager.shared.localizedString(
                for: "8461_no_logged_in_user"
            )
        }

        // MARK: - Login / Signup Alerts
        static var emptyFieldsTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_empty_fields_title"
            )
        }
        static var invalidCredentialmsg: String {
            LanguageManager.shared.localizedString(
                for: "8461_invalid_credential_msg"
            )
        }
        static var fetchFailedMsg: String {
            LanguageManager.shared.localizedString(for: "8461_fetch_failed_msg")
        }
        static var fieldsToFillMsg: String {
            LanguageManager.shared.localizedString(
                for: "8461_fields_to_fill_msg"
            )
        }

        static var nameMissingTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_name_missing_title"
            )
        }
        static var nameMissingMsg: String {
            LanguageManager.shared.localizedString(for: "8461_name_missing_msg")
        }

        static var emailMissingTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_email_missing_title"
            )
        }
        static var emailMissingMsg: String {
            LanguageManager.shared.localizedString(
                for: "8461_email_missing_msg"
            )
        }

        static var emailexistingTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_email_existing_title"
            )
        }
        static var emailexistinMsg: String {
            LanguageManager.shared.localizedString(
                for: "8461_email_existing_msg"
            )
        }

        static var invalidEmailTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_invalid_email_title"
            )
        }
        static var invalidEmailMsg: String {
            LanguageManager.shared.localizedString(
                for: "8461_invalid_email_msg"
            )
        }

        static var adddressMissingTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_address_missing_title"
            )
        }
        static var addressMissingMsg: String {
            LanguageManager.shared.localizedString(
                for: "8461_address_missing_msg"
            )
        }

        static var mobileMissingTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_mobile_missing_title"
            )
        }
        static var mobileMissingMsg: String {
            LanguageManager.shared.localizedString(
                for: "8461_mobile_missing_msg"
            )
        }

        static var passwordMissingTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_password_missing_title"
            )
        }
        static var passwordMissinMsg: String {
            LanguageManager.shared.localizedString(
                for: "8461_password_missing_msg"
            )
        }

        static var invalidPasswordTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_invalid_password_title"
            )
        }
        static var invalidPasswordMsg: String {
            LanguageManager.shared.localizedString(
                for: "8461_invalid_password_msg"
            )
        }

        static var notMatchPasswordTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_not_match_password_title"
            )
        }
        static var notMatchPasswordMsg: String {
            LanguageManager.shared.localizedString(
                for: "8461_not_match_password_msg"
            )
        }
        static var userRegisterSuccessMsg: String {
            LanguageManager.shared.localizedString(for: "8461_Alert_user_save")
        }
        static var successTitle: String {
            LanguageManager.shared.localizedString(
                for: "8461_Alert_success_title"
            )
        }

        // MARK: - OTP / Card / Profile Messages
        static var OtpSuccessMsg: String {
            LanguageManager.shared.localizedString(for: "8461_otp_success_msg")
        }
        static var cardSuccessMsg: String {
            LanguageManager.shared.localizedString(for: "8461_card_success_msg")
        }
        static var invalidCard: String {
            LanguageManager.shared.localizedString(for: "8461_invalid_card")
        }
        static var invalidCardMsg: String {
            LanguageManager.shared.localizedString(for: "8461_invalid_card_msg")
        }
        static var enterCardNumber: String {
            LanguageManager.shared.localizedString(
                for: "8461_enter_card_number"
            )
        }
        static var firstName: String {
            LanguageManager.shared.localizedString(
                for: "8461_first_name_missing"
            )
        }
        static var lastName: String {
            LanguageManager.shared.localizedString(
                for: "8461_last_name_missing"
            )
        }
        static var errMonth: String {
            LanguageManager.shared.localizedString(for: "8461_err_month")
        }
        static var errYear: String {
            LanguageManager.shared.localizedString(for: "8461_err_year")
        }
        static var cardExpiry: String {
            LanguageManager.shared.localizedString(for: "8461_card_expiry")
        }
        static var errSecurityCode: String {
            LanguageManager.shared.localizedString(
                for: "8461_err_security_code"
            )
        }
        static var invalidMobile: String {
            LanguageManager.shared.localizedString(for: "8461_invalid_mobile")
        }
        static var ProfileUpdate: String {
            LanguageManager.shared.localizedString(for: "8461_profile_update")
        }

        // MARK: - Onboarding / Services / Buttons
        static var serviceTitle1: String {
            LanguageManager.shared.localizedString(for: "8461_service_title1")
        }
        static var serviceMsg1: String {
            LanguageManager.shared.localizedString(for: "8461_service_msg1")
        }

        static var serviceTitle2: String {
            LanguageManager.shared.localizedString(for: "8461_service_title2")
        }
        static var serviceMsg2: String {
            LanguageManager.shared.localizedString(for: "8461_service_msg2")
        }

        static var serviceTitle3: String {
            LanguageManager.shared.localizedString(for: "8461_service_title3")
        }
        static var serviceMsg3: String {
            LanguageManager.shared.localizedString(for: "8461_service_msg3")
        }

        static var nextButton: String {
            LanguageManager.shared.localizedString(for: "8461_next_button")
        }
        static var doneButton: String {
            LanguageManager.shared.localizedString(for: "8461_done_button")
        }
    }

    struct StoryBoard {
        static let HomeStoryBoard = "HomeStoryBoard"
        static let main = "Main"
        static let MenuStoryBoard = "MenuStoryBoard"
        static let MoreStoryBoard = "MoreStoryBoard"
        static let ProductStoryBoard = "ProductStoryBoard"
        static let Services = "Services"
        static let User = "User"
    }

    struct AboutUs {
        static var strTxt1: String {
            LanguageManager.shared.localizedString(for: "8461_about_txt1")
        }
        static var strTxt2: String {
            LanguageManager.shared.localizedString(for: "8461_about_txt2")
        }
        static var strTxt3: String {
            LanguageManager.shared.localizedString(for: "8461_about_txt3")
        }
        static var strTxt4: String {
            LanguageManager.shared.localizedString(for: "8461_about_txt4")
        }
        static var strTxt5: String {
            LanguageManager.shared.localizedString(for: "8461_about_txt5")
        }
        static var strTxt6: String {
            LanguageManager.shared.localizedString(for: "8461_about_txt6")
        }
        static var strTxt7: String {
            LanguageManager.shared.localizedString(for: "8461_about_txt7")
        }
    }

    struct Notification {
        static var notification1: String {
            LanguageManager.shared.localizedString(for: "8461_notification1")
        }
        static var notificationTime: String {
            LanguageManager.shared.localizedString(for: "8461_notificationTime")
        }
        static var notification2: String {
            LanguageManager.shared.localizedString(for: "8461_notification2")
        }
        static var notification3: String {
            LanguageManager.shared.localizedString(for: "8461_notification3")
        }
        static var notification4: String {
            LanguageManager.shared.localizedString(for: "8461_notification4")
        }
        static var notification5: String {
            LanguageManager.shared.localizedString(for: "8461_notification5")
        }
        static var notification6: String {
            LanguageManager.shared.localizedString(for: "8461_notification6")
        }
        static var notification7: String {
            LanguageManager.shared.localizedString(for: "8461_notification7")
        }
        static var notification8: String {
            LanguageManager.shared.localizedString(for: "8461_notification8")
        }
        static var notification9: String {
            LanguageManager.shared.localizedString(for: "8461_notification9")
        }
        static var notification10: String {
            LanguageManager.shared.localizedString(for: "8461_notification10")
        }
        static var notification11: String {
            LanguageManager.shared.localizedString(for: "8461_notification11")
        }
        static var notification12: String {
            LanguageManager.shared.localizedString(for: "8461_notification12")
        }
        static var notification13: String {
            LanguageManager.shared.localizedString(for: "8461_notification13")
        }
        static var notification14: String {
            LanguageManager.shared.localizedString(for: "8461_notification14")
        }
        static var notification15: String {
            LanguageManager.shared.localizedString(for: "8461_notification15")
        }
    }

    struct Inbox {
        static var inboxTitle1: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_title1")
        }
        static var inboxMsg1: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_msg1")
        }
        static var inboxTime: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_time1")
        }

        static var inboxTitle2: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_title2")
        }
        static var inboxMsg2: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_msg2")
        }
        static var inboxTime2: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_time2")
        }

        static var inboxTitle3: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_title3")
        }
        static var inboxMsg3: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_msg3")
        }

        static var inboxTitle4: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_title4")
        }
        static var inboxMsg4: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_msg4")
        }

        static var inboxTitle5: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_title5")
        }
        static var inboxMsg5: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_msg5")
        }

        static var inboxTitle6: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_title6")
        }
        static var inboxMsg6: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_msg6")
        }

        static var inboxTitle7: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_title7")
        }
        static var inboxMsg7: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_msg7")
        }

        static var inboxTitle8: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_title8")
        }
        static var inboxMsg8: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_msg8")
        }

        static var inboxTitle9: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_title9")
        }
        static var inboxMsg9: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_msg9")
        }

        static var inboxTitle10: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_title10")
        }
        static var inboxMsg10: String {
            LanguageManager.shared.localizedString(for: "8461_inbox_msg10")
        }
    }

    struct ViewControllers {
        static let About = "AboutUsViewController"
        static let Cart = "CartViewController"
        static let Address = "ChangeAddressViewController"
        static let Checkout = "CheckOutViewController"
        static let Dessert = "DessertsViewController"
        static let forgotPassword = "ForgotPasswordViewController"
        static let Home = "HomeViewController"
        static let Login = "LoginViewController"
        static let Menu = "MenuBarViewController"
        static let SignUp = "SignUpViewController"
        static let More = "MoreViewController"
        static let MyOrder = "MyOrderViewController"
        static let NewPassword = "NewPasswordViewController"
        static let Offers = "OffersViewController"
        static let Orderlist = "OrderListViewController"
        static let OTP = "OTPViewController"
        static let payment = "PaymentViewController"
        static let ProductDetail = "ProductDetailViewController"
        static let Profile = "ProfileViewController"
        static let Service = "ServiceViewController"
        static let Splash = "SplashViewController"
        static let Wishlist = "WishListViewController"
    }

    struct Menu {
        static var food: String {
            LanguageManager.shared.localizedString(for: "8461_category_food")
        }
        static var bevarages: String {
            LanguageManager.shared.localizedString(
                for: "8461_category_beverages"
            )
        }
        static var desserts: String {
            LanguageManager.shared.localizedString(
                for: "8461_category_desserts"
            )
        }
    }

    struct More {
        static var payment: String {
            LanguageManager.shared.localizedString(for: "8461_more_payment")
        }
        static var myOrders: String {
            LanguageManager.shared.localizedString(for: "8461_more_myorders")
        }
        static var notifications: String {
            LanguageManager.shared.localizedString(
                for: "8461_more_notifications"
            )
        }
        static var inbox: String {
            LanguageManager.shared.localizedString(for: "8461_more_inbox")
        }
        static var aboutUs: String {
            LanguageManager.shared.localizedString(for: "8461_more_about")
        }
        static var wishlist: String {
            LanguageManager.shared.localizedString(for: "8461_more_wishlist")
        }
        static var changeLanguage: String {
            LanguageManager.shared.localizedString(
                for: "8461_more_change_language"
            )
        }
        static var changeTheme: String {
            LanguageManager.shared.localizedString(
                for: "8461_more_change_theme"
            )
        }
    }

    struct NavTitle {
        static var payment: String {
            LanguageManager.shared.localizedString(for: "8461_nav_payment")
        }
        static var more: String {
            LanguageManager.shared.localizedString(for: "8461_nav_more")
        }
        static var aboutUs: String {
            LanguageManager.shared.localizedString(for: "8461_nav_about_us")
        }
        static var inbox: String {
            LanguageManager.shared.localizedString(for: "8461_nav_inbox")
        }
        static var notification: String {
            LanguageManager.shared.localizedString(for: "8461_nav_notification")
        }
        static var wishlist: String {
            LanguageManager.shared.localizedString(for: "8461_nav_wishlist")
        }
        static var dessert: String {
            LanguageManager.shared.localizedString(for: "8461_nav_dessert")
        }
        static var profile: String {
            LanguageManager.shared.localizedString(for: "8461_nav_profile")
        }
        static var menu: String {
            LanguageManager.shared.localizedString(for: "8461_nav_menu")
        }
        static var offers: String {
            LanguageManager.shared.localizedString(for: "8461_nav_offers")
        }
        static var checkout: String {
            LanguageManager.shared.localizedString(for: "8461_nav_checkout")
        }
        static var myOrder: String {
            LanguageManager.shared.localizedString(for: "8461_nav_my_order")
        }
        static var orderlist: String {
            LanguageManager.shared.localizedString(for: "8461_nav_orderlist")
        }
        static var changeAddress: String {
            LanguageManager.shared.localizedString(
                for: "8461_nav_change_address"
            )
        }
        static var cart: String {
            LanguageManager.shared.localizedString(for: "8461_nav_cart")
        }  // Added Cart
    }

    struct Services {
        static var serviceTitle1: String {
            LanguageManager.shared.localizedString(for: "8461_service_title1")
        }
        static var serviceMsg1: String {
            LanguageManager.shared.localizedString(for: "8461_service_msg1")
        }

        static var serviceTitle2: String {
            LanguageManager.shared.localizedString(for: "8461_service_title2")
        }
        static var serviceMsg2: String {
            LanguageManager.shared.localizedString(for: "8461_service_msg2")
        }

        static var serviceTitle3: String {
            LanguageManager.shared.localizedString(for: "8461_service_title3")
        }
        static var serviceMsg3: String {
            LanguageManager.shared.localizedString(for: "8461_service_msg3")
        }
    }

    struct CardForm {
        static var cardNumber: String {
            return LanguageManager.shared.localizedString(
                for: "8461_card_number"
            )
        }
        static var expiryMonth: String {
            return LanguageManager.shared.localizedString(
                for: "8461_expiry_month"
            )
        }
        static var expiryYear: String {
            return LanguageManager.shared.localizedString(
                for: "8461_expiry_year"
            )
        }
        static var securityCode: String {
            return LanguageManager.shared.localizedString(
                for: "8461_security_code"
            )
        }
        static var firstName: String {
            return LanguageManager.shared.localizedString(
                for: "8461_first_name"
            )
        }
        static var lastName: String {
            return LanguageManager.shared.localizedString(for: "8461_last_name")
        }
    }

    struct CardLabels {
        static var removeCard: String {
            return LanguageManager.shared.localizedString(
                for: "8461_remove_card"
            )
        }
        static var addCreditOrDebitCard: String {
            return LanguageManager.shared.localizedString(
                for: "8461_add_credit_or_debit_card"
            )
        }
        static var addCard: String {
            return LanguageManager.shared.localizedString(for: "8461_add_card")
        }
        static var expiry: String {
            return LanguageManager.shared.localizedString(for: "8461_Expiry")
        }
        static var paymentMethod: String {
            return LanguageManager.shared.localizedString(
                for: "8461_label_Payment_Method"
            )
        }

    }
}
