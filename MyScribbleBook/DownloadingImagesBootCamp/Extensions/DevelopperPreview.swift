//
//  DevelopperPreview.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 25.07.23.
//

import Foundation
import SwiftUI


extension PreviewProvider {
    
    static var dev : DevelopperPreview {
        return DevelopperPreview()
    }
    
}

class DevelopperPreview {
    
    
    
    let photoArray = Photo(albumId: 1, id: 2, title: "Title", url: "https://jsonplaceholder.typicode.com/photos", thumbnailUrl: "https://jsonplaceholder.typicode.com/photos")
    
    
}
