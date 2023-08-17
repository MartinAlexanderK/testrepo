//
//  FavoritesViewModel.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 08.08.23.
//

import Foundation
import Combine


@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published private(set) var userFavoriteProducts: [UserFavoriteProuduct] = []
    private var cancellables = Set<AnyCancellable>()
    
    func addListenerForFavorites() {
        guard let authResult = try? AuthentificationManager.shared.getAuthenticatedUser() else {return}
        UserManager.shared.addListenerForAllUserFavoriteProducts(userId: authResult.uid)
            .sink { completion in
                
            } receiveValue: {[weak self] products in
                self?.userFavoriteProducts = products
            }
            .store(in: &cancellables)
    }
    func removeFromFavorites(favoriteProductId:String) {
        Task {
            let authResult = try AuthentificationManager.shared.getAuthenticatedUser()
            
            try? await UserManager.shared.removeUserFavoriteProduct(userId: authResult.uid, favoriteProductId: favoriteProductId)
        }
    }
    
    
}
