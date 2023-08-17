//
//  SignInEmailView.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import SwiftUI

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSigninView: Bool
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.blue.opacity(0.6))
                .cornerRadius(10)
            SecureField("Passoword", text: $viewModel.passoword)
                .padding()
                .background(Color.blue.opacity(0.6))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSigninView = false
                        return
                    }
                    catch {
                        print(error)
                    }
                    do {
                        try await viewModel.signIn()
                        showSigninView = false
                        return
                    }
                    catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign in or Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.7))
                    .cornerRadius(10)
            }
            Spacer()

        }
        .padding()
        .navigationTitle("Sign in and up")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView(showSigninView: .constant(false))
        }
    }
}
