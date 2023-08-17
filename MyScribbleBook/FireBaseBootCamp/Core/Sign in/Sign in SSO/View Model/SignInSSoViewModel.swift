//
//  SignInSSoViewModel.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

@MainActor
final class SignInSsoViewModel: ObservableObject {
    
    
    
    
    func signInWithGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthentificationManager.shared.signInWithGoogle(token: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createUser(user: user)
    }
    func signInAnonymous() async throws {
        let authDataResult = try await AuthentificationManager.shared.signInAnonymously()
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createUser(user: user)
    }
}
