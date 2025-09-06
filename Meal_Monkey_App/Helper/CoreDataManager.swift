import CoreData
import Foundation
import UIKit

class CoreDataManager {
    // Singleton instance
    static let shared = CoreDataManager()
    private init() {}

    // Core Data context (shortcut for AppDelegate context)
    private var context: NSManagedObjectContext {
        app.persistentContainer.viewContext
    }
//    private var context = app.persistentContainer.viewContext // we can also write this way
    
    // Save context if there are unsaved changes
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed saving context: \(error)")
            }
        }
    }

    // MARK: - User Functions

    /// Fetch user by email
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

    /// Check if an email already exists in Core Data
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

    // MARK: - Orders

    /// Save an order for the user
    func saveOrder(for user: User, products: [ProductModel]) {
        let order = OrderList(context: context)
        order.user = user
        order.products = products.toData()  // Store products as Data
        saveContext()
        print("Order saved for user: \(user.email ?? "")")
    }

    /// Fetch all orders for a user
    func fetchOrders(for user: User) -> [[ProductModel]] {
        let fetchRequest: NSFetchRequest<OrderList> = OrderList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user == %@", user)

        do {
            let orders = try context.fetch(fetchRequest)
            // Convert stored Data back to ProductModel array
            return orders.compactMap { $0.products?.toProducts() ?? [] }
        } catch {
            print("Failed to fetch orders: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Cart

    /// Add a product to cart (or update quantity if already exists)
    func addToCart(for user: User, product: ProductModel, quantity: Int) {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(
            format: "user == %@ AND productId == %d",
            user,
            product.intId
        )

        do {
            if let existing = try context.fetch(request).first {
                // Update quantity if item already exists
                existing.quantity += Int64(quantity)
            } else {
                // Create new cart item
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

    /// Fetch all cart items for a user
    func fetchCart(for user: User) -> [ProductModel] {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)

        do {
            let items = try context.fetch(request)
            // Map CartItem back to ProductModel
            return items.map {
                ProductModel(
                    intId: Int($0.productId),
                    strProductName: $0.productName ?? "",
                    strProductDescription: "",  // No description stored
                    floatProductRating: 0.0,  // Default value
                    doubleProductPrice: $0.productPrice,
                    strProductImage: $0.productImage ?? "",
                    intProductQty: Int($0.quantity),
                    intTotalNumberOfRatings: 0,  // Default value
                    objProductCategory: .Gujarati,
                    objProductType: .food
                )
            }
        } catch {
            print("Fetch cart failed: \(error)")
            return []
        }
    }

    /// Clear all cart items for a user
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
            print(" Failed to clear cart: \(error.localizedDescription)")
        }
    }

    /// Remove a specific product from the cart
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
                print("🗑️ Removed from cart: \(item.productName ?? "")")
            } else {
                print("Product not found in cart")
            }
        } catch {
            print(" Failed to remove item: \(error.localizedDescription)")
        }
    }

    // MARK: - Wishlist

    /// Add product to wishlist
    func addToWishlist(for user: User, productId: Int) {
        let item = WishListItem(context: context)
        item.id = Int64(productId)
        item.user = user
        saveContext()
    }

    /// Remove product from wishlist
    func removeFromWishlist(for user: User, productId: Int) {
        if let items = user.wishlist as? Set<WishListItem>,
            let toRemove = items.first(where: { $0.id == Int64(productId) })
        {
            context.delete(toRemove)
            saveContext()
        }
    }

    /// Check if a product is already in wishlist
    func isInWishlist(for user: User, productId: Int) -> Bool {
        if let items = user.wishlist as? Set<WishListItem> {
            return items.contains { $0.id == Int64(productId) }
        }
        return false
    }

    /// Fetch all product IDs from wishlist
    func fetchWishlistIds(for user: User) -> [Int] {
        return (user.wishlist as? Set<WishListItem>)?.map { Int($0.id) } ?? []
    }
    
    // Add Card for Payment
    func addCard(for user: User, card: PaymentModel) {
        let newCard = CardItem(context: context)
        newCard.cardId = Int64(card.intCardId ?? 0)
        newCard.firstName = card.strFirstName
        newCard.lastName = card.strLastName
        newCard.cardNumber = Int64(card.intCardNumber ?? 0)
        newCard.expiryMonth = Int64(card.intMonth ?? 0)
        newCard.expiryYear = Int64(card.intYear ?? 0)
        newCard.user = user
        saveContext()
        print("💳 Added new card: \(newCard.cardNumber)")
    }

    /// Fetch all cards
    func fetchCards(for user: User) -> [PaymentModel] {
        let request: NSFetchRequest<CardItem> = CardItem.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        do {
            return try context.fetch(request).map {
                PaymentModel(
                    intCardId: Int($0.cardId),
                    intCardNumber: Int64(Int($0.cardNumber)),
                    intMonth: Int64(Int($0.expiryMonth)),
                    intYear: Int64(Int($0.expiryYear)),
                    strFirstName: $0.firstName ?? "",
                    strLastName: $0.lastName ?? ""
                )
            }
        } catch {
            print("❌ Fetch cards failed: \(error)")
            return []
        }
    }

    /// Delete one card
    func deleteCard(for user: User, cardId: Int) {
        let request: NSFetchRequest<CardItem> = CardItem.fetchRequest()
        request.predicate = NSPredicate(
            format: "user == %@ AND cardId == %d",
            user,
            Int64(cardId)
        )
        do {
            if let card = try context.fetch(request).first {
                context.delete(card)
                saveContext()
                print("🗑️ Deleted card: \(cardId)")
            }
        } catch {
            print("❌ Delete card failed: \(error)")
        }
    }
}
