//
//  Query+Ext.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 08.08.23.
//

//getDocumentsWithSnapShot
//getDocuments
//startOptionally
//aggregateCount
//addSnapShotListener


import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

extension Query {
    
    
    //getDocumentsWithSnapshot
    func getDocumentsWithSnapshot<T>(as type:T.Type) async throws -> (products: [T],lastDocument:DocumentSnapshot?) where T:Decodable {
        let snapshot = try await self.getDocuments()
        let products = try snapshot.documents.map({try $0.data(as: type)})
        return (products, snapshot.documents.last)
    }
    
    
    //getDocuments
    func getDocuments<T>(as type:T.Type) async throws ->[T] where T:Decodable {
        try await getDocumentsWithSnapshot(as: type).products
    }
    //startOptionally
    func startOptionally(afterDocument lastDocument:DocumentSnapshot?) -> Query {
        guard let lastDocument else {return self}
        return self.start(afterDocument: lastDocument)
    }
    //aggregateCount
    func aggregateCount() async throws -> Int {
        let snapshot = try await self.count.getAggregation(source: .server)
        return Int(truncating: snapshot.count)
    }
    //addSnapshotListener
    func addSnapshotListener<T>(as type:T.Type) async throws -> (AnyPublisher<[T],Error>, ListenerRegistration) where T:Decodable {
        let publisher = PassthroughSubject<[T],Error>()
        let listener = self.addSnapshotListener { querySnapshot, error in
            guard let encodedDocuments = querySnapshot?.documents else {return}
            let documents = encodedDocuments.compactMap({try? $0.data(as: type)})
            publisher.send(documents)
        }
        return (publisher.eraseToAnyPublisher(), listener)
    }
    
    
    
    
    
}
