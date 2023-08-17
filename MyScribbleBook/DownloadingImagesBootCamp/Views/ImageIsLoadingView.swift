//
//  ImageIsLoadingView.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 26.07.23.
//

import SwiftUI

struct ImageIsLoadingView: View {
    
    @StateObject var loader : ImagesLoadingViewModel
    init(url: String, key: String) {
        _loader = StateObject(wrappedValue: ImagesLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            }
            else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
        }
    }
}

struct ImageIsLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageIsLoadingView(url: "", key: "")
    }
}
