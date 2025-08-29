import Foundation
class CartManager {
    static let shared = CartManager()
    private init() {}

    var count: Int {
        get { UserDefaults.standard.integer(forKey: "CartCount") }
        set {
            UserDefaults.standard.set(newValue, forKey: "CartCount")
            
            // 🔴 Notify all screens that cart was updated
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
    }

    func add(quantity: Int = 1) {
        count += quantity
    }

    func remove(quantity: Int = 1) {
        count = max(count - quantity, 0)
    }
    func clear(){
        count = 0
    }
}
