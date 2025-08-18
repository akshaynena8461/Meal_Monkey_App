import Foundation

class ProductModel:Codable{
    var intId: Int = 0
    var strProductName: String = ""
    var strProductDescription: String = ""
    var floatProductRating: Float = 0.0
    var doubleProductPrice: Double = 0.0
    var strProductImage: String = ""
    var intProductQty: Int?
    var intTotalNumberOfRatings: Int = 0
    var objProductCategory: ProductCategory = .Gujarati
    var objProductType: ProductType = .food
    var objAddFavorite:Bool?
  
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
}
enum ProductType: String,Codable {
    case food
    case Beverages
    case Desserts
}

enum ProductCategory:String,Codable,CaseIterable {
    case All
    case Punjabi
    case Chinese
    case Gujarati
    case SouthIndian
    case WesternFood
}

extension Array where Element == ProductModel {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

extension Data {
    func toProducts() -> [ProductModel]? {
        return try? JSONDecoder().decode([ProductModel].self, from: self)
    }
}
