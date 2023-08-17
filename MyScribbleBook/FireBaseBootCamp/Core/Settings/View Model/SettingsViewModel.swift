//
//  SettingsViewModel.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth


@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResultModel? = nil
    
    func loadAuthProviders() {
        if let providers = try? AuthentificationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    func loadAuthUser() {
        self.authUser = try? AuthentificationManager.shared.getAuthenticatedUser()
    }
    func signOut() throws {
        try AuthentificationManager.shared.signOut()
    }
    func deleteAccount() async throws{
        try await AuthentificationManager.shared.delete()
    }
    func resetPassword() async throws {
        
        let authUser = try AuthentificationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {throw URLError(.appTransportSecurityRequiresSecureConnection)}
        
        try await AuthentificationManager.shared.resetPassord(email: email)
        
    }
    func updateEmail() async throws {
        let email = "test123@gmail.com"
        try await AuthentificationManager.shared.updateEmail(email: email)
    }
    func updatePassword() async throws {
        let password = "password123"
        try await AuthentificationManager.shared.updatePassword(password: password)
    }
    func linkGoogleAccount() async throws {
        let helper = SignInGoogleHelper()
        let token = try await helper.signIn()
        self.authUser = try await AuthentificationManager.shared.linkGoogle(token: token)
    }
    func linkEmailAccount() async throws {
        let email = "test123@Gmail.com"
        let password = "password123"
        self.authUser = try await AuthentificationManager.shared.linkEmailCredentials(email: email, password: password)
    }
}
