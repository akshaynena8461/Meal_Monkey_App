import CoreData
import UIKit

// Global reference to the AppDelegate for easy access
var app = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Global Data Arrays
    var arrCart: [ProductModel] = []  // Holds products added to the cart
    var arrOrder: [[ProductModel]] = []  // Stores multiple orders (array of product arrays)
    var cartItems: [ProductModel] = []  // Temporary cart items
    var arrCard: [PaymentModel] = []  // Holds payment card information
    var arrWishList: [ProductModel] = [] // Stores wishlist products
    var arrOrderDetail:[ProductModel] = [] //Store OrederDetails data

    // MARK: - App Launch
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]?
    ) -> Bool {
        // Called when the app has finished launching
        if let savedData = UserDefaults.standard.data(forKey: "savedCards") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(
                [PaymentModel].self,
                from: savedData
            ) {
                arrCard = decoded
            }
        }
        return true
    }

    // MARK: - Scene Configuration
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Return the scene configuration for new scenes
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        // Called when the user discards a scene session
        // Resources specific to the discarded scenes can be released here
    }

    // MARK: - Core Data Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Meal_Monkey_App")  // CoreData model name
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                // Fatal error if Core Data fails to load
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Save Core Data Context
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Handle save error
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(arrCard) {
            UserDefaults.standard.set(encoded, forKey: "savedCards")
        }
    }
}
