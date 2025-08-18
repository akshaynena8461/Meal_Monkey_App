import CoreData
import Foundation
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    private var context: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer
            .viewContext
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed saving context: \(error)")
            }
        }
    }

    func saveUser(
        name: String,
        email: String,
        mobile: String,
        address: String,
        password: String
    ) {
        let user = User(context: context)
        user.name = name
        user.email = email
        user.mobileNumber = mobile
        user.address = address
        user.password = password
        saveContext()
        print("User saved successfully")
    }

    func fetchUser(email: String, password: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "email == %@ AND password == %@",
            email,
            password
        )

        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print(" Failed to fetch user: \(error.localizedDescription)")
            return nil
        }
    }

    func fetchUserbyEmail(byEmail email: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print(
                "Failed to fetch user by email: \(error.localizedDescription)"
            )
            return nil
        }
    }

    func isEmailExists(email: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            return !(try context.fetch(fetchRequest).isEmpty)
        } catch {
            print("Failed to check email: \(error.localizedDescription)")
            return false
        }
    }

    func saveOrder(for user: User, products: [ProductModel]) {
        let order = OrderList(context: context)
        order.userEmail = user.email
        order.products = products.toData()
        saveContext()
        print("Order saved for user: \(user.email ?? "")")
    }

    func fetchOrders(for user: User) -> [[ProductModel]] {
        let fetchRequest: NSFetchRequest<OrderList> = OrderList.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "user == %@",
            user.email ?? ""
        )

        do {
            let orders = try context.fetch(fetchRequest)
            return orders.compactMap { $0.products?.toProducts() }
        } catch {
            print("Failed to fetch orders: \(error.localizedDescription)")
            return []
        }
    }

    func addToCart(for user: User, product: ProductModel, quantity: Int) {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(
            format: "user == %@ AND productId == %d",
            user,
            product.intId
        )

        do {
            if let existing = try context.fetch(request).first {
                existing.quantity += Int64(quantity)
            } else {
                let item = CartItem(context: context)
                item.productId = Int64(product.intId)
                item.productName = product.strProductName
                item.productPrice = product.doubleProductPrice
                item.productImage = product.strProductImage
                item.quantity = Int64(quantity)
                item.user = user
            }
            saveContext()
        } catch {
            print("Add to cart failed: \(error)")
        }
    }

    func fetchCart(for user: User) -> [ProductModel] {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)

        do {
            let items = try context.fetch(request)
            return items.map {
                ProductModel(
                    intId: Int($0.productId),
                    strProductName: $0.productName ?? "",
                    strProductDescription: "",
                    floatProductRating: 0.0,
                    doubleProductPrice: $0.productPrice,
                    strProductImage: $0.productImage ?? "",
                    intProductQty: Int($0.quantity),
                    intTotalNumberOfRatings: 0,
                    objProductCategory: .Gujarati,
                    objProductType: .food
                )
            }
        } catch {
            print("Fetch cart failed: \(error)")
            return []
        }
    }

    func clearCart(for user: User) {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)

        do {
            let items = try context.fetch(request)
            for item in items {
                context.delete(item)
            }
            saveContext()
            print("Cart cleared for user: \(user.email ?? "")")
        } catch {
            print("Failed to clear cart: \(error.localizedDescription)")
        }
    }

    func removeFromCart(for user: User, productId: Int) {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(
            format: "user == %@ AND productId == %d",
            user,
            productId
        )

        do {
            if let item = try context.fetch(request).first {
                context.delete(item)
                saveContext()
                print("Removed from cart: \(item.productName ?? "")")
            } else {
                print("Product not found in cart")
            }
        } catch {
            print("Failed to remove item: \(error.localizedDescription)")
        }
    }

    func addToWishlist(for user: User, productId: Int) {
        let item = WishListItem(context: context)
        item.id = Int64(productId)
        item.user = user
        saveContext()
    }

    func removeFromWishlist(for user: User, productId: Int) {
        if let items = user.wishlist as? Set<WishListItem>,
            let toRemove = items.first(where: { $0.id == Int64(productId) })
        {
            context.delete(toRemove)
            saveContext()
        }
    }

    func isInWishlist(for user: User, productId: Int) -> Bool {
        if let items = user.wishlist as? Set<WishListItem> {
            return items.contains { $0.id == Int64(productId) }
        }
        return false
    }

    func fetchWishlistIds(for user: User) -> [Int] {
        return (user.wishlist as? Set<WishListItem>)?.map { Int($0.id) } ?? []
    }
}
