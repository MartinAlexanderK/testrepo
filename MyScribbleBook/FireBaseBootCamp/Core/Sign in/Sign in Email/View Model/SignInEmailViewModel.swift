//
//  SignInEmailViewModel.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import Foundation

final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var passoword = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !passoword.isEmpty else {
            print("no email or passoword found")
            return}
        let authDataResult = try await AuthentificationManager.shared.createUser(email: email, password: passoword)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createUser(user: user)
    }
    
    func signIn() async throws{
        guard !email.isEmpty, !passoword.isEmpty else {
            print("no email or passoword found ")
            return
        }
        try await AuthentificationManager.shared.signInUser(email: email, password: passoword)
    }
    
}

