

import Foundation

class PrdouctModel{
    var intId:Int = 0
    var strProductName:String = ""
    var strProductDescription:String = ""
    var floatProductRating:Float = 0.0
    var doubleProductPrice:Double = 0.0
    var strProductImage:String = ""
    var intProductQty:Int?
    var intTotalNumberOfRatings:Int = 0
    var objProductCategory:ProductCategory = .Gujarati
    var objProductType:ProductType = .food
    
    init(intId: Int, strProductName: String, strProductDescription: String, floatProductRating: Float, doubleProductPrice: Double, strProductImage: String, intProductQty: Int? = nil, intTotalNumberOfRatings: Int, objProductCategory: ProductCategory, objProductType: ProductType) {
        self.intId = intId
        self.strProductName = strProductName
        self.strProductDescription = strProductDescription
        self.floatProductRating = floatProductRating
        self.doubleProductPrice = doubleProductPrice
        self.strProductImage = strProductImage
        self.intProductQty = intProductQty
        self.intTotalNumberOfRatings = intTotalNumberOfRatings
        self.objProductCategory = objProductCategory
        self.objProductType = objProductType
    }
    
    class func addProductData()->[PrdouctModel]{
        return [PrdouctModel(intId: 1, strProductName: "Paneer Tikka masala", strProductDescription: "Very Testy food", floatProductRating: 4.5, doubleProductPrice: 200, strProductImage: "ic_paneertikka", intTotalNumberOfRatings: 120, objProductCategory: .Punjabi, objProductType: .food)]
    }
}
enum ProductType:String{
    case food
    case Beverages
    case Desserts
}

enum ProductCategory:String{
    case Punjabi
    case Chinese
    case Gujarati
    case SouthIndian
    case WesternFood
}
