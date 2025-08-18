import CoreData
import UIKit

var app = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var arrCart: [ProductModel] = []
    var arrOrder: [[ProductModel]] = []
    var cartItems: [ProductModel] = []
    var arrCard: [PaymentModel] = []
    var arrWishList:[ProductModel] = []

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {

        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {

    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Meal_Monkey_App")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getUser(byEmail email: String) -> User? {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)

        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("❌ Failed to fetch user: \(error)")
            return nil
        }
    }

    func saveCart(for email: String, products: [ProductModel]) {
        let context = persistentContainer.viewContext

        guard let user = getUser(byEmail: email) else {
            print("❌ User not found for email: \(email)")
            return
        }

        // Clear old items
        if let existingItems = user.cartItem as? Set<CartItem> {
            for item in existingItems {
                context.delete(item)
            }
        }

        // Save new items
        for product in products {
            let cartItem = CartItem(context: context)
            cartItem.productId = Int64(product.intId)
            cartItem.productName = product.strProductName
            cartItem.productImage = product.strProductImage
            cartItem.productPrice = product.doubleProductPrice
            cartItem.quantity = Int64(product.intProductQty ?? 1)
            cartItem.productCategory = product.objProductCategory.rawValue
            cartItem.productType = product.objProductType.rawValue
            cartItem.user = user
        }

        do {
            try context.save()
            print("✅ Cart saved for \(email)")
        } catch {
            print("❌ Failed to save cart: \(error)")
        }
    }

    func fetchCart(for email: String) -> [ProductModel] {
        guard let user = getUser(byEmail: email) else {
            print("❌ User not found for email: \(email)")
            return []
        }

        return user.cartItem?.allObjects as? [ProductModel] ?? []

    }

    //    func applicationWillTerminate(_ application: UIApplication) {
    //
    //        let encoder = JSONEncoder()
    //        if let encoded = try? encoder.encode(app.arrCart) {
    //            UserDefaults.standard.set(encoded, forKey: "cartData")
    //            UserDefaults.standard.synchronize()
    //        }
    //        if let encoded = try? encoder.encode(app.arrOrder) {
    //            UserDefaults.standard.set(encoded, forKey: "orderlistData")
    //            UserDefaults.standard.synchronize()
    //        }
    //        if let encoded = try? encoder.encode(app.arrCard) {
    //            UserDefaults.standard.set(encoded, forKey: "cardData")
    //            UserDefaults.standard.synchronize()
    //        }
    //    }

}
