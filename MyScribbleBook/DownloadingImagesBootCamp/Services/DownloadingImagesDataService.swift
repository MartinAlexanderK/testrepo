//
//  DownloadingImagesDataService.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 26.07.23.
//

import Foundation
import SwiftUI
import Combine


class DownloadingImagesDataService {
    
    static let instance = DownloadingImagesDataService()
    
    @Published var dataArray : [Photo] = []
    
    let url : String = "https://jsonplaceholder.typicode.com/photos"
    
    var imageSubscriber : AnyCancellable?
        
    private init(){
        download(urlString: url)
    }
    
    private func download(urlString : String){
        guard let url = URL(string: urlString) else {return}
        
       imageSubscriber =  NetworkingManager.download(url: url)
            .receive(on: DispatchQueue.main)
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedImages in
                self?.dataArray = returnedImages
                self?.imageSubscriber?.cancel()
            }
    }
}
