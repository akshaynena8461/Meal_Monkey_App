import Foundation

// Model representing a payment card, conforms to Codable for easy encoding/decoding
class PaymentModel: Codable {

    //Card id as an integer (e.g.,1,2,3,..)
    var intCardId: Int?

    // Card number as a string (e.g., "1234 5678 9012 3456")
    var intCardNumber: Int64?

    // Expiration month (e.g., "01", "12")
    var intMonth: Int64?

    // Expiration year (e.g., "2025")
    var intYear: Int64?

    // Security/CVV code as integer (e.g., 123)
    var intSecurityCode: Int64?

    // First name of the cardholder
    var strFirstName: String?

    // Last name of the cardholder
    var strLastName: String?

    // Initializer with default values for optional properties
    init(
        intCardId: Int? = nil,
        intCardNumber: Int64? = nil,
        intMonth: Int64? = nil,
        intYear: Int64? = nil,
        intSecurityCode: Int64? = nil,
        strFirstName: String? = nil,
        strLastName: String? = nil
    ) {
        self.intCardId = intCardId
        self.intCardNumber = intCardNumber
        self.intMonth = intMonth
        self.intYear = intYear
        self.intSecurityCode = intSecurityCode
        self.strFirstName = strFirstName
        self.strLastName = strLastName
    }
}
