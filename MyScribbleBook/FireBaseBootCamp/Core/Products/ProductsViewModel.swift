//
//  ProductsViewModel.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 03.08.23.
//

import Foundation
import FirebaseFirestore

@MainActor
final class ProductsViewModel:ObservableObject {
    
    @Published private(set) var products : [Product] = []
    @Published var selectedFilter:FilterOption? = nil
    @Published var selectedCategory:CategoryOption? = nil
    private var lastDocument: DocumentSnapshot? = nil
    
    
    
    
    enum FilterOption: String, CaseIterable {
        case noFilter
        case priceHigh
        case priceLow
        
        
        var priceDescending:Bool? {
            switch self {
            case .noFilter:
                return nil
            case .priceHigh:
                return true
            case .priceLow:
                return false
            }
        }
    }
    
    
    enum CategoryOption: String, CaseIterable {
        case noCategory
        case smartphones
        case laptops
        case fragrances
        
        var categoryKey:String? {
            if self == .noCategory {
                return nil
            } else {
                return self.rawValue
            }
        }
    }
    
    func getProducts() {
        Task {
            let (newProduct, lastDocument) = try await ProductManager.shared.getAllProducts(forCategorycategory: selectedCategory?.categoryKey, priceDescending: selectedFilter?.priceDescending, lastDocument: lastDocument, count: 10)
            self.products.append(contentsOf: newProduct)
            if let lastDocument {
                self.lastDocument = lastDocument
            }
        }
    }
    func getProductsCount() {
        Task {
            let count = try await ProductManager.shared.getProductsCount()
            print ("The curerent product count is at \(count)")
        }
    }
    func filterOption(option:FilterOption) async throws {
        self.selectedFilter = option
        self.products = []
        self.lastDocument = nil
        self.getProducts()
    }
    func categoryOption(option: CategoryOption) async throws {
        self.selectedCategory = option
        self.products = []
        self.lastDocument = nil
        self.getProducts()
    }
    func addUserFavoriteProduct(productId:Int) {
        Task {
            let authDataResult = try AuthentificationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.addUserFavoriteProduct(userId: authDataResult.uid, productId: productId)
        }
    }
        
}
