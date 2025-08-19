import Foundation

// Model representing a payment card, conforms to Codable for easy encoding/decoding
class PaymentModel: Codable {
    
    // Card number as a string (e.g., "1234 5678 9012 3456")
    var strCardNumber: String?
    
    // Expiration month (e.g., "01", "12")
    var strMonth: String?
    
    // Expiration year (e.g., "2025")
    var strYear: String?
    
    // Security/CVV code as integer (e.g., 123)
    var intSecurityCode: Int?
    
    // First name of the cardholder
    var strFirstName: String?
    
    // Last name of the cardholder
    var strLastName: String?

    // Initializer with default values for optional properties
    init(
        strCardNumber: String? = nil,
        strMonth: String? = nil,
        strYear: String? = nil,
        intSecurityCode: Int? = nil,
        strFirstName: String? = nil,
        strLastName: String? = nil
    ) {
        self.strCardNumber = strCardNumber
        self.strMonth = strMonth
        self.strYear = strYear
        self.intSecurityCode = intSecurityCode
        self.strFirstName = strFirstName
        self.strLastName = strLastName
    }
}
