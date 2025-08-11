import Foundation

class PaymentModel {
    var intCardNumber: Int64?
    var strMonth: String?
    var strYear: String?
    var intSecurityCode: Int?
    var strFirstName: String?
    var strLastName: String?

    init(
        intCardNumber: Int64? = nil,
        strMonth: String? = nil,
        strYear: String? = nil,
        intSecurityCode: Int? = nil,
        strFirstName: String? = nil,
        strLastName: String? = nil
    ) {
        self.intCardNumber = intCardNumber
        self.strMonth = strMonth
        self.strYear = strYear
        self.intSecurityCode = intSecurityCode
        self.strFirstName = strFirstName
        self.strLastName = strLastName
    }

    class func addcardDetails() -> [PaymentModel] {
        return [
            PaymentModel(
                intCardNumber: 4_111_111_111_111_111,
                strMonth: "01",
                strYear: "2026",
                intSecurityCode: 123,
                strFirstName: "Akshay",
                strLastName: "Nena"
            ),
            PaymentModel(
                intCardNumber: 4_222_222_222_222_222,
                strMonth: "02",
                strYear: "2027",
                intSecurityCode: 456,
                strFirstName: "John",
                strLastName: "Doe"
            ),
            PaymentModel(
                intCardNumber: 4_333_333_333_333_333,
                strMonth: "03",
                strYear: "2028",
                intSecurityCode: 789,
                strFirstName: "Jane",
                strLastName: "Smith"
            ),
            PaymentModel(
                intCardNumber: 4_444_444_444_444_444,
                strMonth: "04",
                strYear: "2029",
                intSecurityCode: 321,
                strFirstName: "Mark",
                strLastName: "Taylor"
            ),
            PaymentModel(
                intCardNumber: 4_555_555_555_555_555,
                strMonth: "05",
                strYear: "2030",
                intSecurityCode: 654,
                strFirstName: "Emily",
                strLastName: "Clark"
            ),
        ]
    }
}
