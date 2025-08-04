import Foundation

class AboutModel {
    var strText: String?

    init(strText: String? = nil) {
        self.strText = strText
    }

    class func addAboutData() -> [AboutModel] {
        return [
            AboutModel(
                strText:
                    "Our mission is to deliver a seamless and intuitive shopping experience that prioritizes user satisfaction. We aim to create a platform where browsing, purchasing, and managing products feels effortless, thanks to our simple user interface and reliable service."
            ),

            AboutModel(
                strText:
                    "We are dedicated to maintaining high standards of performance, transparency, and trust. Our team continuously works to enhance app functionality, ensure data privacy, and provide responsive customer support, making your shopping journey smooth and secure."
            ),

            AboutModel(
                strText:
                    "Your feedback matters. If you have any questions, suggestions, or encounter any issues, we’re here to help. Reach out through our support page or email us directly. Together, we strive to build a better and more inclusive experience for everyone."
            ),
            AboutModel(
                strText:
                    "We believe that technology should serve people. That’s why we constantly refine our platform based on real user behavior and needs, aiming to make every interaction faster, simpler, and more enjoyable."
            ),

            AboutModel(
                strText:
                    "Security is our priority. We use industry-standard protocols to safeguard your personal information and provide a safe and secure shopping environment at all times."
            ),

            AboutModel(
                strText:
                    "We value accessibility and inclusiveness. Our platform is designed to be usable by people of all backgrounds, devices, and technical abilities, ensuring that everyone can benefit from our services."
            ),

            AboutModel(
                strText:
                    "Sustainability matters to us. We support eco-friendly business practices and work with partners who share our values to reduce our environmental impact."
            ),

        ]
    }

}
