//
//  RootView.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                    TabBarView(showSignInView: $showSignInView)
                
            }
        }
        .onAppear {
            let authUser = try? AuthentificationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                SignInSsoView(showSignInView: $showSignInView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
