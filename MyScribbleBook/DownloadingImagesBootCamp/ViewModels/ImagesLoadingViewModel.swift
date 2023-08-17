//
//  ImagesLoadingViewModel.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 26.07.23.
//

import Foundation
import SwiftUI
import Combine

class ImagesLoadingViewModel : ObservableObject {
    
    let manager = PhotoFileManager.instance
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = false
    
    let imageUrl : String
    let imageKey: String
    
    let folderName = "newFolder"
    
    init(url: String, key: String) {
        imageUrl = url
        imageKey = key
        getImage()
    }
    
    private func getImage() {
        if let savedImage = manager.getImage(folderName: folderName, imageName: imageKey) {
            self.image = savedImage
            print("Getting saved image now")
        }
        else {
            downloadImage()
            print("Downloading image now")
        }
    }
    private func downloadImage(){
        guard let url = URL(string: imageUrl) else {return}
        self.isLoading = true
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map({UIImage(data: $0.data)})
            .sink { [weak self] _  in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedData in
                guard
                    let self = self,
                    let returnedImages = returnedData
                else {
                    return
                }
                self.image = returnedImages
                self.isLoading = false
                self.manager.saveImage(folderName: folderName, imageName: imageKey, image: returnedImages)
            }
            .store(in: &cancellables)

    }
    
    
    
    
}
