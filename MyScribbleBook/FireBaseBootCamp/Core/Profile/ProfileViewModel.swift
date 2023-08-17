//
//  ProfileViewModel.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 01.08.23.
//

import Foundation


//@MainActor
//final class ProfileViewModel: ObservableObject {
//    @Published private(set) var user: DBUser? = nil
//
//
//    func loadUser() async throws {
//        let authDataResult = try AuthentificationManager.shared.getAuthenticatedUser()
//        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
//    }
//    func togglePremiumStatus() {
//        guard let user else {return}
//        let currentValue = user.isPremium ?? false
//        Task {
//            try await UserManager.shared.updateUserPremiumStatus(userId:user.userId , isPremium: !currentValue)
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//        }
//    }
//
//    func addUserPreference(text:String){
//        guard let user else {return}
//        Task {
//            try await UserManager.shared.addUserPreference(userId:user.userId, preference:text)
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//        }
//    }
//    func removeUserPreference(text:String){
//        guard let user else {return}
//        Task {
//            try await UserManager.shared.removeUserPreference(userId:user.userId, preference:text)
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//        }
//    }
//
//    func addFavoriteMovie() {
//        guard let user else {return}
//        let movie = Movie(id: "1", title: "james bond", isPopular: true)
//        Task {
//            try await UserManager.shared.addFavoriteMovie(userId:user.userId, movie:movie)
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//        }
//    }
//    func removeFavoriteMovie() {
//        guard let user else {return}
//        Task {
//            try await UserManager.shared.removeFavoriteMovie(userId:user.userId)
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//        }
//    }
//}


@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user : DBUser? = nil
    
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthentificationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func togglePremiumStatus()  {
        guard let user else {return}
        let currentValue = user.isPremium ?? false
        Task {
            try await UserManager.shared.updateUserPremiumStatus(userId:user.userId ,isPremium:!currentValue)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    //add user preference
    func addUserPreference(text:String) {
        guard let user else {return}
        Task {
            try await UserManager.shared.addUserPreference(userId:user.userId,pereference:text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    //remove user preference
    func removeUserPreference(text:String) {
        guard let user else {return}
        Task {
            try await UserManager.shared.removeUserPreference(userId:user.userId,pereference:text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    //add favorite movie
    func addFavoriteMovie() {
        guard let user else {return}
        let movie = Movie(id: "1", title: "The silence of the lambs", isPopular: false)
        Task {
            try await UserManager.shared.addFavoriteMovie(userId:user.userId,movie:movie)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    //remove favorite movie
    func removeFavoriteMovie() {
        guard let user else {return}
        Task {
            try await UserManager.shared.removeFavoriteMovie(userId:user.userId)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
}
