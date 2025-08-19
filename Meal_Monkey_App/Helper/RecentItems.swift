//
//  UI Recent Items.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 11/08/25.
//

import Foundation

/// A singleton helper class to manage a list of recently viewed or accessed products.
/// This class maintains a fixed-size list of recent `ProductModel` items, ensuring no duplicates,
/// and provides methods to add, retrieve, and clear recent products.
class RecentItemsHelper {
    
    /// Shared singleton instance to access `RecentItemsHelper` globally.
    static let shared = RecentItemsHelper()
    
    /// Private initializer to prevent multiple instances.
    private init() {}
    
    /// Array holding the recent products.
    /// The most recent product is at the front (index 0).
    private var recentItems: [ProductModel] = []
    
    /// Maximum number of recent items to keep track of.
    private let maxItems = 7
    
    /**
     Adds a new product to the recent items list.
     
     - Parameter product: The `ProductModel` instance to be added.
     
     This method ensures that if the product already exists in the list,
     it is first removed to avoid duplicates, and then inserted at the front
     of the list (most recent). If the total count exceeds `maxItems`, the oldest
     product (at the end) is removed.
     */
    func addProduct(_ product: ProductModel) {
        // Check if product already exists in recentItems
        if let existingIndex = recentItems.firstIndex(where: { $0.intId == product.intId }) {
            // Remove the existing product to avoid duplicates
            recentItems.remove(at: existingIndex)
        }
        // Insert the new product at the beginning to mark it as most recent
        recentItems.insert(product, at: 0)
        
        // Ensure the list does not exceed the maximum allowed items
        if recentItems.count > maxItems {
            recentItems.removeLast()
        }
    }
    
    /**
     Retrieves the current list of recent products.
     
     - Returns: An array of `ProductModel` objects, ordered from most recent to oldest.
     */
    func getRecentItems() -> [ProductModel] {
        return recentItems
    }
    
    /// Clears all recent items from the list.
    func clear() {
        recentItems.removeAll()
    }
}
