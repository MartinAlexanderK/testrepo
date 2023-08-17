//
//  SignInWithGoogleHelper.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift


struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name : String?
    let email : String?
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController() else {throw URLError(.cannotFindHost)}
        
        let gidSignInResults = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResults.user.idToken?.tokenString else {throw URLError(.badURL)}
        let accesToken = gidSignInResults.user.accessToken.tokenString
        let name = gidSignInResults.user.profile?.name
        let email = gidSignInResults.user.profile?.email
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accesToken, name: name, email: email)
        return tokens
        
    }

    
    
    
    
    
}
