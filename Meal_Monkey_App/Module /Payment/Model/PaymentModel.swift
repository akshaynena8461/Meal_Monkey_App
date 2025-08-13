import Foundation

class PaymentModel {
    var strCardNumber: String?
    var strMonth: String?
    var strYear: String?
    var intSecurityCode: Int?
    var strFirstName: String?
    var strLastName: String?

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
