import Foundation

class OfferModel {
    var strTitle: String?
    var floatRating: Float?
    var strTitle2: String?
    var strImage: String?

    init(
        strTitle: String? = nil,
        floatRating: Float? = nil,
        strTitle2: String? = nil,
        strImage: String? = nil
    ) {
        self.strTitle = strTitle
        self.floatRating = floatRating
        self.strTitle2 = strTitle2
        self.strImage = strImage
    }

    class func addOffersData() -> [OfferModel] {
        return [
            OfferModel(
                strTitle: "Café de Noires",
                floatRating: 4.9,
                strTitle2: "(124 ratings) Café     Western Food",
                strImage: "Offers_Img_1"
            ),
            OfferModel(
                strTitle: "Isso",
                floatRating: 4.9,
                strTitle2: "(124 ratings) Café     Western Food",
                strImage: "Offers_Img_2"
            ),
            OfferModel(
                strTitle: "Cafe Beans",
                floatRating: 4.9,
                strTitle2: "(124 ratings) Café     Western Food",
                strImage: "Offers_Img_3"
            ),
        ]
    }

}
