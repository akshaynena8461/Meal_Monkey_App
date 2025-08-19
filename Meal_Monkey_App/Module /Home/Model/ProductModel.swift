import Foundation

// MARK: - Product Model
class ProductModel: Codable {
    var intId: Int = 0                          // Unique product ID
    var strProductName: String = ""             // Product name
    var strProductDescription: String = ""      // Product description
    var floatProductRating: Float = 0.0         // Product rating (0.0 - 5.0)
    var doubleProductPrice: Double = 0.0        // Product price
    var strProductImage: String = ""            // Image name for product
    var intProductQty: Int?                      // Quantity (optional)
    var intTotalNumberOfRatings: Int = 0        // Total number of ratings
    var objProductCategory: ProductCategory = .Gujarati // Category enum
    var objProductType: ProductType = .food     // Type enum (food, dessert, beverages)
    var objAddFavorite: Bool?                   // Is product marked favorite (optional)

    // MARK: - Initializer
    init(intId: Int,
         strProductName: String,
         strProductDescription: String,
         floatProductRating: Float,
         doubleProductPrice: Double,
         strProductImage: String,
         intProductQty: Int? = nil,
         intTotalNumberOfRatings: Int,
         objProductCategory: ProductCategory,
         objProductType: ProductType) {

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

// MARK: - Product Type Enum
enum ProductType: String, Codable {
    case food
    case Beverages
    case Desserts
}

// MARK: - Product Category Enum
enum ProductCategory: String, Codable, CaseIterable {
    case All
    case Punjabi
    case Chinese
    case Gujarati
    case SouthIndian
    case WesternFood
}

// MARK: - Array <ProductModel> Codable Extensions
extension Array where Element == ProductModel {
    func toData() -> Data? {
        // Converts array of ProductModel to JSON data
        return try? JSONEncoder().encode(self)
    }
}

extension Data {
    func toProducts() -> [ProductModel]? {
        // Converts JSON data back to array of ProductModel
        return try? JSONDecoder().decode([ProductModel].self, from: self)
    }
}
