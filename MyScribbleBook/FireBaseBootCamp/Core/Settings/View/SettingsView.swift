//
//  SettingsView.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel = SettingsViewModel()
    @Binding var showSignIn : Bool
    
    var body: some View {
        List {
            Button("Logg out") {
                Task {
                    do {
                       try viewModel.signOut()
                        showSignIn = true
                    }
                    catch {
                        print(error)
                    }
                }
            }
            Button(role: .destructive) {
                Task {
                    do {
                       try await viewModel.deleteAccount()
                        showSignIn = true
                    }
                    catch {
                        print(error)
                    }
                }
            } label: {
                Text("Delete Account")
            }
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
            if viewModel.authUser?.isAnonymous == true {
                anonymousSection
            }

        }
        .onAppear {
            viewModel.loadAuthUser()
            viewModel.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSignIn: .constant(false))
    }
}

extension SettingsView {
    
    private var emailSection: some View {
        
        Section("Email Section") {
        
            Button("Reset Password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("passowrd reset")
                    }
                    catch{
                        print(error)
                    }
                }
            }
            Button("update Password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("passowrd updated")
                    }
                    catch{
                        print(error)
                    }
                }
            }
            Button("update email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("email updated")
                    }
                    catch{
                        print(error)
                    }
                }
            }
            
            
        }
        
    }
    private var anonymousSection: some View {
        
        Section("Anonymous Section") {
        
            Button("link Google") {
                Task {
                    do {
                        try await viewModel.linkGoogleAccount()
                        print("google linked")
                    }
                    catch{
                        print(error)
                    }
                }
            }
            Button("link apple") {
                Task {
                    do {
                        try await viewModel.linkGoogleAccount()
                        print("apple linked")
                    }
                    catch{
                        print(error)
                    }
                }
            }
            Button("link email") {
                Task {
                    do {
                        try await viewModel.linkEmailAccount()
                        print("email linked")
                    }
                    catch{
                        print(error)
                    }
                }
            }
            
            
        }
        
        
    }

}
