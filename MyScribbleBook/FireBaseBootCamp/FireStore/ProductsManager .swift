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
    
    //productCollection
    private let productCollection = Firestore.firestore().collection("products")
    //productDocument
    private func productsDocument(productId:String) -> DocumentReference {
        productCollection.document(productId)
    }
    
    //uploadProduct
    func uploadProduct(product:Product) async throws {
        try productsDocument(productId: String(product.id)).setData(from: product, merge: false)
    }
    //getProduct
    func getProduct(productId:String) async throws -> Product {
        try await productsDocument(productId: productId).getDocument(as: Product.self)
    }
    
    //getAllProductsQuery
    func getAllProductsQuery() -> Query {
        productCollection
    }
    //getAllProductsFilteredByCategoryQuery
    func getAllProductsFilteredByCategoryQuery(category:String) -> Query {
        productCollection
            .whereField(Product.CodingKeys.category.rawValue, isEqualTo: category)
    }
    //getAllProductsSortedByPriceQuery
    func getAllProductsSortedByPriceQuery(isDescending:Bool) -> Query {
        productCollection
            .order(by: Product.CodingKeys.price.rawValue, descending: isDescending)
    }
    //getAllProductsFilteredByCategoryandSortedByPriceQuery
    func getAllProductsFilteredByCategoryandSortedByPriceQuery(category:String,isDescending:Bool) -> Query {
        productCollection
            .whereField(Product.CodingKeys.category.rawValue, isEqualTo: category)
            .order(by: Product.CodingKeys.price.rawValue, descending: isDescending)

    }
    
    
    //getAllProducts
    func getAllProducts() async throws -> [Product] {
        try await productCollection
            .getDocuments(as: Product.self)
    }
    //getAllProductsCount
    func getAllProductsCount() async throws -> Int {
        try await productCollection
            .aggregateCount()
    }
    
    
}
