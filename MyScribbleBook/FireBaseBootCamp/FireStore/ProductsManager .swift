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
    //productDocument
    private func productDocument(productId:String) -> DocumentReference {
        productsCollection.document(productId)
    }
    
    //uploadProduct
    func uploadProduct(product:Product) async throws {
        try productDocument(productId: String(product.id)).setData(from: product, merge: false)
    }
    //getProduct
    func getProduct(productId:String) async throws -> Product {
        try await productDocument(productId: productId).getDocument(as: Product.self)
    }
    
    //getAllProductsQuery
    func getAllProductsQuery() -> Query {
        productsCollection
    }
    //getAllProductsFilteredByCategoryQuery
    func getAllProductsFilteredByCategoryQuery(category:String) -> Query {
        productsCollection
            .whereField(Product.CodingKeys.category.rawValue, isEqualTo: category)
    }
    //getAllProductsSortedByPriceQuery
    func getAllProductsSortedByPriceQuery(descending:Bool) -> Query {
        productsCollection
            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
    }
    //getAllProductsFilteredByCategoryandSortedByPriceQuery
    func getAllProductsFilteredByCategoryandSortedByPriceQuery(category:String,descending:Bool) -> Query {
        productsCollection
            .whereField(Product.CodingKeys.category.rawValue, isEqualTo: category)
            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
    }
    //getAllProducts
    func getAllProducts(isCategory category:String?,priceDescending descending:Bool?, lastDoucment: DocumentSnapshot?) async throws -> ([Product], DocumentSnapshot?) {
        var query:Query = getAllProductsQuery()
        if let category, let descending {
            query = getAllProductsFilteredByCategoryandSortedByPriceQuery(category: category, descending: descending)
        } else if let category {
            query = getAllProductsFilteredByCategoryQuery(category: category)
        }
        else if let descending {
            query = getAllProductsSortedByPriceQuery(descending: descending)
        }
        return try await query
            .startOptionally(aferDocument: lastDoucment)
            .getDocumentsWithSnapshot(as: Product.self)
    }
    //getAllProductsCount
    func getAllProductsCount() async throws -> Int {
        try await productsCollection
            .aggregateCount()
    }
}
