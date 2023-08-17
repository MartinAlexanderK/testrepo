//
//  ImageLoadingRowView.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 26.07.23.
//

import SwiftUI

struct ImageLoadingRowView: View {
    
    let photo : Photo
    
    
    var body: some View {
        HStack {
            ImageIsLoadingView(url: photo.url, key: "\(photo.id)")
                .frame(width: 65,height: 65)
            VStack (alignment: .leading){
                Text(photo.title)
                    .font(.headline)
                Text(photo.url)
                    .font(.subheadline)
                    .italic()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ImageLoadingRowView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingRowView(photo: dev.photoArray)
    }
}
