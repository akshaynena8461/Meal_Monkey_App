
import Foundation

class OrderModel {
    var intOrderId: Int?
    var arrProducts:[ProductModel]?
    var dblTotalAmount: Double?
    
    init(intOrderId: Int? = nil, arrProducts: [ProductModel]? = nil, dblTotalAmount: Double? = nil) {
        self.intOrderId = intOrderId
        self.arrProducts = arrProducts
        self.dblTotalAmount = dblTotalAmount
    }
}
class OrderManager {
    static let shared = OrderManager()
    private init() {}
    
    var orders: [OrderModel] = []
}
