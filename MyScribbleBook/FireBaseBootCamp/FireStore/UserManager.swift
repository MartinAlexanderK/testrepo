//
//  UserManager.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//struct DBUser : Codable {
//    let userId: String
//    let isAnonymous : Bool?
//    let isPremium: Bool?
//    let email: String?
//    let photoUrl: String?
//    let dateCreated: Date?
//
//    //init Nr 1
//    init(userId: String, isAnonymous: Bool?, isPremium: Bool?, email: String?, photoUrl: String?, dateCreated: Date?) {
//        self.userId = userId
//        self.isAnonymous = isAnonymous
//        self.isPremium = isPremium
//        self.email = email
//        self.photoUrl = photoUrl
//        self.dateCreated = dateCreated
//    }
//    //init Nr 2
//    init(auth: AuthDataResultModel) {
//        self.userId = auth.uid
//        self.isAnonymous = auth.isAnonymous
//        self.email = auth.email
//        self.photoUrl = auth.photoUrl
//        self.dateCreated = Date()
//        self.isPremium = false
//    }
//    //encoder
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.userId, forKey: .userId)
//        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
//        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
//        try container.encodeIfPresent(self.email, forKey: .email)
//        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
//        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
//    }
//    enum CodingKeys: String, CodingKey {
//        case userId = "user_id"
//        case isAnonymous = "is_anonymous"
//        case isPremium = "is_premium"
//        case email = "email"
//        case photoUrl = "photo_url"
//        case dateCreated = "date_created"
//    }
//    //decoder
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.userId = try container.decode(String.self, forKey: .userId)
//        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
//        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
//        self.email = try container.decodeIfPresent(String.self, forKey: .email)
//        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
//        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
//    }
//}
//
//final class UserManager {
//    static let shared = UserManager()
//    private init() {}
//
//    //getting collection and document
//    private let userCollection = Firestore.firestore().collection("user")
//    private func userDocument(userId: String) -> DocumentReference {
//        userCollection.document(userId)
//    }
//    //create user
//    func createUser(user: DBUser) async throws {
//        try userDocument(userId: user.userId).setData(from: user, merge: false)
//    }
//    //get user
//    func getUser(userId: String) async throws -> DBUser {
//        try await userDocument(userId: userId).getDocument(as: DBUser.self)
//    }
//    //update user premium status
//    func updateUserPremiumStatus(userId:String, isPremium:Bool) async throws {
//        let data : [String:Any] = [DBUser.CodingKeys.isPremium.rawValue : isPremium]
//        try await userDocument(userId: userId).updateData(data)
//    }
//}

struct Movie: Codable {
    let id: String
    let title: String
    let isPopular : Bool
}

struct DBUser: Codable  {
    let userId: String
    let isAnonymous : Bool?
    let isPremium: Bool?
    let email: String?
    let photoUrl : String?
    let dateCreated :Date?
    let preferences : [String]?
    let favoriteMovie: Movie?
    
    
    init(auth: AuthDataResultModel){
        self.userId = auth.uid
        self.isAnonymous = auth.isAnonymous
        self.isPremium = false
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.preferences = nil
        self.favoriteMovie = nil
    }
    
    init(userId: String, isAnonymous: Bool? = nil, isPremium: Bool? = nil, email: String? = nil, photoUrl: String? = nil, dateCreated: Date? = nil, preferences: [String]? = nil, favoriteMovie: Movie? = nil) {
        self.userId = userId
        self.isAnonymous = isAnonymous
        self.isPremium = isPremium
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.preferences = preferences
        self.favoriteMovie = favoriteMovie
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.preferences, forKey: .preferences)
        try container.encodeIfPresent(self.favoriteMovie, forKey: .favoriteMovie)
    }
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isAnonymous = "is_anonymous"
        case isPremium = "is_premium"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case preferences = "preferences"
        case favoriteMovie = "favorite_movie"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.preferences = try container.decodeIfPresent([String].self, forKey: .preferences)
        self.favoriteMovie = try container.decodeIfPresent(Movie.self, forKey: .favoriteMovie)
    }
    
}


struct UserFavoriteProuduct: Codable {
    let id: String
    let productId: Int
    let dateCreated: Date
    
    
    enum CodingKeys: String, CodingKey {
        case id  = "id"
        case productId = "product_id"
        case dateCreated = "date_created"
    }
    
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.productId, forKey: .productId)
        try container.encode(self.dateCreated, forKey: .dateCreated)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.productId = try container.decode(Int.self, forKey: .productId)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
    }
    
    
}
//userCollection
//userDocument

//userFavoriteProductCollection
//userFavoriteProductDocument
//userFavoriteProductsListener


//encoder
//decoder

//createNewUser
//getUser

//updateUserPremiumStatus

//add user preferences
//remove user preferences

//add favorite movie
//remove favorite movie

//addUserFavoriteProduct
//removeUserFavoriteProduct

//getAllUserFavoriteProducts

//NEW removeListenerForAllUserFavoriteProducts
//NEW addListenerForAllUserFavoriteProducts

final class UserManager {
    
    //userCollection
    private let userCollection = Firestore.firestore().collection("users")
    //userDocument
    private func userDocument(userId:String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    //userFavoriteProductCollection
    func userFavoriteProductCollection(userId:String) -> CollectionReference {
        userDocument(userId: userId).collection("favorite_products")
    }
    
    //userFavoriteProductDocument
    func userFavoriteProductDocument(userId:String,productId:String) -> DocumentReference {
        userFavoriteProductCollection(userId: userId).document(productId)
    }
    //userFavoriteProductListener
    private var userFavoriteProductListener : ListenerRegistration? = nil
    
    //encoder
    private let encoder : Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        return encoder
    }()
    //decoder
    private let decoder : Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        return decoder
    }()
    //updateUserPremiumStatus
    func updateUserPremiumStatus(userId:String, isPremium:Bool) async throws {
        let data : [String:Any] = [DBUser.CodingKeys.preferences.rawValue : isPremium]
        try await userDocument(userId: userId).updateData(data)
    }
    
    //addUserSettings
    func addUserSettings(userId:String, settings:String) async throws {
        let data : [String:Any] = [DBUser.CodingKeys.preferences.rawValue : FieldValue.arrayUnion([settings])]
        try await userDocument(userId: userId).updateData(data)
    }
    //removeUserSettings
    func removeUserSettings(userId:String, settings:String) async throws {
        let data : [String:Any] = [DBUser.CodingKeys.preferences.rawValue : FieldValue.arrayRemove([settings])]
        try await userDocument(userId: userId).updateData(data)
    }
    //addUserFavoriteMovie
    func addUserFavoriteMovie(userId:String, movie:Movie) async throws {
        let movie = try encoder.encode(movie)
        let data : [String:Any] = [DBUser.CodingKeys.favoriteMovie.rawValue : movie]
        try await userDocument(userId: userId).updateData(data)
    }
    //removeUserFavoriteMovie
    func removeUserFavoriteMovie(userId:String) async throws {
        let data : [String:Any?] = [DBUser.CodingKeys.favoriteMovie.rawValue : nil]
        try await userDocument(userId: userId).updateData(data as [AnyHashable : Any])
    }
    //addUserFavoriteProduct
    func addUserFavoriteProduct(userId:String, productId:Int) async throws {
        let document = userFavoriteProductCollection(userId: userId).document()
        let documentId = document.documentID
        
        let data : [String:Any] = [
            UserFavoriteProuduct.CodingKeys.id.rawValue : documentId,
            UserFavoriteProuduct.CodingKeys.productId.rawValue : productId,
            UserFavoriteProuduct.CodingKeys.dateCreated.rawValue : Timestamp()
        ]
        try await document.setData(data)
    }
    //removeUserFavoriteProduct
    func removeUserFavoriteProduct(userId:String, productId:String) async throws {
        try await userFavoriteProductDocument(userId: userId, productId: productId).delete()
    }

    //getAllUserFavoriteProducts
    func getAllUserFavoriteProducts(userId:String) async throws -> [Product] {
        try await userFavoriteProductCollection(userId: userId)
            .getDocuments(as: Product.self)
    }
    
    //adUserFavoriteProductListener
    func adUserFavoriteProductListener(userId:String) -> AnyPublisher<[UserFavoriteProuduct], Error> {
       let (publisher, listener) =  userFavoriteProductCollection(userId: userId)
            .addSnapshotListener(as: UserFavoriteProuduct.self)
        self.userFavoriteProductListener = listener
        return publisher
    }
    //removeUserFavoriteProductListener
    func removeUserFavoriteProductListener(userId:String) {
        self.userFavoriteProductListener?.remove()
    }    
}


