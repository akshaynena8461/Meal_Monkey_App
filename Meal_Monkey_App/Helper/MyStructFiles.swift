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
          static var errorTitle: String { LanguageManager.shared.localizedString(for: "8461_error_title") }
          static var noLoggedInUser: String { LanguageManager.shared.localizedString(for: "8461_no_logged_in_user") }

          // MARK: - Login / Signup Alerts
          static var emptyFieldsTitle: String { LanguageManager.shared.localizedString(for: "8461_empty_fields_title") }
          static var invalidCredentialmsg: String { LanguageManager.shared.localizedString(for: "8461_invalid_credential_msg") }
          static var fetchFailedMsg: String { LanguageManager.shared.localizedString(for: "8461_fetch_failed_msg") }
          static var fieldsToFillMsg: String { LanguageManager.shared.localizedString(for: "8461_fields_to_fill_msg") }
          
          static var nameMissingTitle: String { LanguageManager.shared.localizedString(for: "8461_name_missing_title") }
          static var nameMissingMsg: String { LanguageManager.shared.localizedString(for: "8461_name_missing_msg") }
          
          static var emailMissingTitle: String { LanguageManager.shared.localizedString(for: "8461_email_missing_title") }
          static var emailMissingMsg: String { LanguageManager.shared.localizedString(for: "8461_email_missing_msg") }
          
          static var emailexistingTitle: String { LanguageManager.shared.localizedString(for: "8461_email_existing_title") }
          static var emailexistinMsg: String { LanguageManager.shared.localizedString(for: "8461_email_existing_msg") }
          
          static var invalidEmailTitle: String { LanguageManager.shared.localizedString(for: "8461_invalid_email_title") }
          static var invalidEmailMsg: String { LanguageManager.shared.localizedString(for: "8461_invalid_email_msg") }
          
          static var adddressMissingTitle: String { LanguageManager.shared.localizedString(for: "8461_address_missing_title") }
          static var addressMissingMsg: String { LanguageManager.shared.localizedString(for: "8461_address_missing_msg") }
          
          static var mobileMissingTitle: String { LanguageManager.shared.localizedString(for: "8461_mobile_missing_title") }
          static var mobileMissingMsg: String { LanguageManager.shared.localizedString(for: "8461_mobile_missing_msg") }
          
          static var passwordMissingTitle: String { LanguageManager.shared.localizedString(for: "8461_password_missing_title") }
          static var passwordMissinMsg: String { LanguageManager.shared.localizedString(for: "8461_password_missing_msg") }
          
          static var invalidPasswordTitle: String { LanguageManager.shared.localizedString(for: "8461_invalid_password_title") }
          static var invalidPasswordMsg: String { LanguageManager.shared.localizedString(for: "8461_invalid_password_msg") }
          
          static var notMatchPasswordTitle: String { LanguageManager.shared.localizedString(for: "8461_not_match_password_title") }
          static var notMatchPasswordMsg: String { LanguageManager.shared.localizedString(for: "8461_not_match_password_msg") }
          static var userRegisterSuccessMsg: String { LanguageManager.shared.localizedString(for: "8461_Alert_user_save") }
          static var successTitle: String { LanguageManager.shared.localizedString( for: "8461_Alert_success_title")}

          // MARK: - OTP / Card / Profile Messages
          static var OtpSuccessMsg: String { LanguageManager.shared.localizedString(for: "8461_otp_success_msg") }
          static var cardSuccessMsg: String { LanguageManager.shared.localizedString(for: "8461_card_success_msg") }
          static var invalidCard: String { LanguageManager.shared.localizedString(for: "8461_invalid_card") }
          static var invalidCardMsg: String { LanguageManager.shared.localizedString(for: "8461_invalid_card_msg") }
          static var enterCardNumber: String { LanguageManager.shared.localizedString(for: "8461_enter_card_number") }
          static var firstName: String { LanguageManager.shared.localizedString(for: "8461_first_name_missing") }
          static var lastName: String { LanguageManager.shared.localizedString(for: "8461_last_name_missing") }
          static var errMonth: String { LanguageManager.shared.localizedString(for: "8461_err_month") }
          static var errYear: String { LanguageManager.shared.localizedString(for: "8461_err_year") }
          static var cardExpiry: String { LanguageManager.shared.localizedString(for: "8461_card_expiry") }
          static var errSecurityCode: String { LanguageManager.shared.localizedString(for: "8461_err_security_code") }
          static var invalidMobile: String { LanguageManager.shared.localizedString(for: "8461_invalid_mobile") }
          static var ProfileUpdate: String { LanguageManager.shared.localizedString(for: "8461_profile_update") }

          // MARK: - Onboarding / Services / Buttons
          static var serviceTitle1: String { LanguageManager.shared.localizedString(for: "8461_service_title1") }
          static var serviceMsg1: String { LanguageManager.shared.localizedString(for: "8461_service_msg1") }
          
          static var serviceTitle2: String { LanguageManager.shared.localizedString(for: "8461_service_title2") }
          static var serviceMsg2: String { LanguageManager.shared.localizedString(for: "8461_service_msg2") }
          
          static var serviceTitle3: String { LanguageManager.shared.localizedString(for: "8461_service_title3") }
          static var serviceMsg3: String { LanguageManager.shared.localizedString(for: "8461_service_msg3") }

          static var nextButton: String { LanguageManager.shared.localizedString(for: "8461_next_button") }
          static var doneButton: String { LanguageManager.shared.localizedString(for: "8461_done_button") }
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
        static let strTxt1 =
            "Our mission is to deliver a seamless and intuitive shopping experience that prioritizes user satisfaction. We aim to create a platform where browsing, purchasing, and managing products feels effortless, thanks to our simple user interface and reliable service."
        static let strTxt2 =
            "We are dedicated to maintaining high standards of performance, transparency, and trust. Our team continuously works to enhance app functionality, ensure data privacy, and provide responsive customer support, making your shopping journey smooth and secure."
        static let strTxt3 =
            "Your feedback matters. If you have any questions, suggestions, or encounter any issues, we’re here to help. Reach out through our support page or email us directly. Together, we strive to build a better and more inclusive experience for everyone."
        static let strTxt4 =
            "We believe that technology should serve people. That’s why we constantly refine our platform based on real user behavior and needs, aiming to make every interaction faster, simpler, and more enjoyable."
        static let strTxt5 =
            "Security is our priority. We use industry-standard protocols to safeguard your personal information and provide a safe and secure shopping environment at all times."
        static let strTxt6 =
            "We value accessibility and inclusiveness. Our platform is designed to be usable by people of all backgrounds, devices, and technical abilities, ensuring that everyone can benefit from our services."
        static let strTxt7 =
            "Sustainability matters to us. We support eco-friendly business practices and work with partners who share our values to reduce our environmental impact."
    }

    struct Notification {
        static let notification1 = "Order placed successfully"
        static let notificationTime = "6d ago"
        static let notification2 = "Your payment has been confirmed"
        static let notification3 = "Your food is being prepared"
        static let notification4 = "Delivery agent assigned"
        static let notification5 = "Your order is on the way"
        static let notification6 = "Special discount available!"
        static let notification7 = "Download our new app update"
        static let notification8 = "Refer a friend and earn"
        static let notification9 = "Limited-time deal ending soon"
        static let notification10 = "Delivery completed"
        static let notification11 = "Rate your last meal"
        static let notification12 = "Weekend offer just for you"
        static let notification13 = "Free delivery on orders above ₹299"
        static let notification14 = "Thanks for being with us!"
        static let notification15 = "New restaurants added near you"
    }

    struct Inbox {
        static let inboxTitle1 = "MealMonkey Promotions"
        static let inboxMsg1 = "Get 20% off on your next meal!"
        static let inboxTime1 = "6th July"
        static let inboxTitle2 = "Order Update"
        static let inboxMsg2 = "Your order is being prepared by the restaurant."
        static let inboxTime = "6th July"
        static let inboxTitle3 = "Delivery Reminder"
        static let inboxMsg3 = "Your delivery agent is on the way."
        static let inboxTitle4 = "Welcome to MealMonkey"
        static let inboxMsg4 = "Thanks for joining us! Start exploring meals."
        static let inboxTitle5 = "Rate Your Experience"
        static let inboxMsg5 = "How was your recent meal order?"
        static let inboxTitle6 = "Flash Sale"
        static let inboxMsg6 = "Enjoy 30% off on all pasta orders today only."
        static let inboxTitle7 = "New Restaurants"
        static let inboxMsg7 = "Discover trending restaurants in your area."
        static let inboxTitle8 = "Weekend Special"
        static let inboxMsg8 = "Free dessert on orders above ₹499."
        static let inboxTitle9 = "MealMonkey Tips"
        static let inboxMsg9 =
            "Customize your orders with special instructions."
        static let inboxTitle10 = "Order Cancelled"
        static let inboxMsg10 = "Your order has been cancelled as requested."
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
}
