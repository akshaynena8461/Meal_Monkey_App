import Foundation

/// Model class representing an Offer item
class OfferModel {
    // MARK: - Properties
    var strTitle: String?        // Primary title of the offer (e.g., restaurant name)
    var floatRating: Float?      // Rating of the offer/restaurant
    var strTitle2: String?       // Secondary title or description (e.g., ratings info, cuisine type)
    var strImage: String?        // Name of the image associated with the offer

    // MARK: - Initializer
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

    // MARK: - Sample Data
    /// Returns an array of sample OfferModel objects
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
