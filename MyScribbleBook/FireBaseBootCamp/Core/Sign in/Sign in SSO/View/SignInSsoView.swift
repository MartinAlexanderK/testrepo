//
//  SignInSsoView.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth


struct SignInSsoView: View {
    
    @StateObject private var viewModel = SignInSsoViewModel()
    @Binding var showSignInView: Bool
    
    
    var body: some View {
        VStack {
            Button {
                Task {
                    do {
                        try await viewModel.signInAnonymous()
                        showSignInView = false
                    }
                    catch{
                        print(error)
                    }
                }
            } label: {
                Text("Sign in Anonymously")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.5))
                    .cornerRadius(10)
            }
            NavigationLink {
                SignInEmailView(showSigninView: $showSignInView)
            } label: {
                Text("Sign in with email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.pink.opacity(0.5))
                    .cornerRadius(10)
            }
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await viewModel.signInWithGoogle()
                        showSignInView = false
                    }
                    catch {
                        print(error)
                    }
                }
            }


        }
        .padding()
        .navigationTitle("Sign up")
    }
}

struct SignInSsoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInSsoView(showSignInView: .constant(false))
        }
    }
}
