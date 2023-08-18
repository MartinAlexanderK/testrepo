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
    func getDocumentsWithSnapshot<T>(as type:T.Type) async throws -> (products: [T], lastDocument: DocumentSnapshot?) where T:Decodable {
        let snapshot = try await self.getDocuments()
        let products = try snapshot.documents.map({try $0.data(as: T.self)})
        return (products, snapshot.documents.last)
    }
    //getDocuments
    func getDocuments<T>(as type:T.Type) async throws -> [T] where T:Decodable {
        return try await getDocumentsWithSnapshot(as: T.self).products
    }
    //startOptionally
    func startOptionally(aferDocument lastDocument: DocumentSnapshot?) -> Query {
        guard let lastDocument else {return self}
        return self.start(afterDocument: lastDocument)
    }
    //aggregateCount
    func aggregateCount() async throws -> Int {
        let snapShot = try await self.count.getAggregation(source: .server)
        return Int(truncating: snapShot.count)
    }
    //addSnapshotListener
    func addSnapshotListener<T>(as type:T.Type) ->(AnyPublisher<[T],Error>, ListenerRegistration) where T:Decodable {
        let publisher = PassthroughSubject<[T],Error>()
        let listener = self.addSnapshotListener { querySnapshot, error in
            guard let encodedDocuments = querySnapshot?.documents else {return}
            let documents = encodedDocuments.compactMap({try? $0.data(as: T.self)})
            publisher.send(documents)
        }
        return (publisher.eraseToAnyPublisher(), listener)
    }
}
