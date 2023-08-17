//
//  NetworkingManager.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 25.07.23.
//

import Foundation
import SwiftUI
import Combine

class NetworkingManager {
    
    //MARK: - Error handling
    
    enum NetowkringError : LocalizedError {
        case barUrl(url:URL)
        case unknownError
        
        var errorDescription: String? {
            switch self {
            case .barUrl(url: let url):
                return "bad url from \(url)"
            case .unknownError:
                return "an unknown error has occured"
            }
        }
    }
    
    //MARK: - handling response from trymap
    
    static func handleResponse(output: URLSession.DataTaskPublisher.Output, url : URL) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else{
            throw NetowkringError.barUrl(url: url)
        }
        return output.data
    }
    
    
    //MARK: - handle completion for sink
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case.finished:
            break
        case .failure(let error):
            print("Error handling completion \(error)")
        }
    }
    
    //MARK: - Download
    
    static func download(url: URL) -> AnyPublisher<Data,Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap({try handleResponse(output: $0, url: url)})
            .eraseToAnyPublisher()
    }
    
}
