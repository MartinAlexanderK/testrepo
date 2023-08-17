//
//  ProductsManager .swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 03.08.23.
//

//productCollection
//productDocument


//uploadProduct
//getProduct

//getAllProductsQuery
//getAllProductsSortedByPriceQuery
//getAllProductsForCateforyQuery
//getAllProductsByPriceAndCategoryQuery


//getAllProducts

//getAllProductsCount

//QUERY:

//getDocumentsWithSnapshot
//getDocument

//startOptionally
//aggregateCount

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift




final class ProductManager {
    
    
    //productsCollection
    private let productsCollection = Firestore.firestore().collection("products")
    //productsDocument
    private func productsDocument(productId:String) -> DocumentReference {
        productsCollection.document(productId)
    }
    
    //uploadProduct
    func uploadProduct(product:Product) async throws  {
        try  productsDocument(productId: String(product.id)).setData(from: product, merge: false)
    }
    //getProduct
    func getProduct(productId:String) async throws -> Product {
        try await productsDocument(productId: productId).getDocument(as: Product.self)
    }
    //getAllProductsQuery
    func getAllProductsQuery() -> Query {
        productsCollection
    }
    //getAllProductsFilteredByCategory
    func getAllProductsFilteredByCategory(category:String) -> Query {
        productsCollection
            .whereField(Product.CodingKeys.category.rawValue, isEqualTo: category)
    }
    //getAllProductsSortedByPrice
    func getAllProductsSortedByPrice(descending:Bool) -> Query {
        productsCollection
            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
    }
    //getAllProductsFilteredByCategoryAndSortedByPrice
    func getAllProductsFilteredByCategoryAndSortedByPrice(category:String,descending:Bool) -> Query {
        productsCollection
            .whereField(Product.CodingKeys.category.rawValue, isEqualTo: category)
            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
    }
    //getAllProducts
    func getAllProducts(isCategory category:String?,priceDescending descending:Bool?, lastDocument: DocumentSnapshot?) async throws -> ([Product],DocumentSnapshot?) {
        var query: Query = getAllProductsQuery()
        if let category, let descending {
            query = getAllProductsFilteredByCategoryAndSortedByPrice(category: category, descending: descending)
        } else if let category {
            query = getAllProductsFilteredByCategory(category: category)
        } else if let descending {
            query = getAllProductsSortedByPrice(descending: descending)
        }
        return try await query
            .startOptionally(afterDocument: lastDocument)
            .getDocumentsWithSnapshot(as: Product.self)
    }
    //getAllProductsCount
    func getAllProductsCount() async throws -> Int {
        try await productsCollection
            .aggregateCount()
    }
    
}
