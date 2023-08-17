//
//  DownloadingImagesViewModel.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 26.07.23.
//

import Foundation
import SwiftUI
import Combine


final class DownloadingImagesViewModel: ObservableObject {
    
    let service = DownloadingImagesDataService.instance
    
    @Published var imagesArray : [Photo] = []
    var cancellabes = Set<AnyCancellable>()
    
    init() {
        subsribeToImage()
    }
    func subsribeToImage() {
        service.$dataArray
            .sink { [weak self] returnedImage in
                self?.imagesArray = returnedImage
            }
            .store(in: &cancellabes)
    }
}
