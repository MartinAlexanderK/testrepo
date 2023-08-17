//
//  AuthentificationManager.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import Foundation
import FirebaseAuth
import Firebase
import GoogleSignIn
import GoogleSignInSwift


struct AuthDataResultModel {
    
    let uid: String
    let email: String?
    let photoUrl: String?
    let isAnonymous: Bool
    
    init(user:User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        self.isAnonymous = user.isAnonymous
    }
}
enum AuthProviderOption: String {
    case email = "password"
    case google = "googe.com"
    case apple = "apple.com"
}


@MainActor
final class AuthentificationManager {
    
    static let shared = AuthentificationManager()
    private init(){}
    
    //MARK: - Generic functions
    func getAuthenticatedUser()throws ->  AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {throw URLError(.badURL)}
        return AuthDataResultModel(user: user)
    }
    func getProviders() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {throw URLError(.badURL)}
        
        var providers : [AuthProviderOption] = []
        
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        return providers
    }
    func signOut() throws {
        try Auth.auth().signOut()
    }
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {throw URLError(.badURL)}
        try await user.delete()
    }
    
    
    
    

}

//MARK: - sign in with email functions
extension AuthentificationManager {
    //create user
    func createUser(email:String, password: String) async throws-> AuthDataResultModel {
         let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    //sign in user
    func signInUser(email:String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    //reset password
    func resetPassord(email:String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    //update password
    func updatePassword(password:String) async throws {
        guard let user = Auth.auth().currentUser else {throw URLError(.badURL)}
        try await user.updatePassword(to: password)
    }
    //update Email
    func updateEmail(email:String) async throws {
        guard let user = Auth.auth().currentUser else {throw URLError(.badURL)}
        try await user.updateEmail(to: email)
    }
}






//MARK: - sign in with SSO functions
extension AuthentificationManager {
    //sign in
    private func signIn(credentials: AuthCredential) async throws -> AuthDataResultModel {
        let autDataResult = try await Auth.auth().signIn(with: credentials)
        return AuthDataResultModel(user: autDataResult.user)
    }
    //sign in Google
    func signInWithGoogle(token:GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: token.idToken, accessToken: token.accessToken)
        return try await signIn(credentials: credential)
    }
}







//MARK: - sign in anonymously functions

extension AuthentificationManager {

    //sign in anonymously
    func signInAnonymously() async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signInAnonymously()
        return AuthDataResultModel(user: authDataResult.user)
    }
    //link credentials
    private func linkCredentials(credentials: AuthCredential) async throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {throw URLError(.badURL)}
        let authDataResult = try await user.link(with: credentials)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    //link email credentials
    func linkEmailCredentials(email:String, password: String) async throws -> AuthDataResultModel {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        return try await linkCredentials(credentials: credential)
    }
    //link google credentials
    func linkGoogle(token:GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: token.idToken, accessToken: token.accessToken)
        return try await linkCredentials(credentials: credential)
        
    }
    
}
