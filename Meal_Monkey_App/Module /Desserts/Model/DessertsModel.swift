import Foundation

class DessertsModel {
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

    class func addDessertsData() -> [DessertsModel] {
        return [
            DessertsModel(
                strTitle: "French Apple Pie",
                floatRating: 4.9,
                strTitle2: "Minute by tuk tuk - Desserts",
                strImage: "Dessert_Img_1"
            ),
            DessertsModel(
                strTitle: "Dark Chocolate Cake",
                floatRating: 4.9,
                strTitle2: "Minute by tuk tuk - Desserts",
                strImage: "Dessert_Img_2"
            ),
            DessertsModel(
                strTitle: "Street Shake",
                floatRating: 4.9,
                strTitle2: "Minute by tuk tuk - Desserts",
                strImage: "Dessert_Img_3"
            ),
            DessertsModel(
                strTitle: "Fudgy Chewy Brownies",
                floatRating: 4.9,
                strTitle2: "Minute by tuk tuk - Desserts",
                strImage: "Dessert_Img_4"
            ),
        ]
    }
}
