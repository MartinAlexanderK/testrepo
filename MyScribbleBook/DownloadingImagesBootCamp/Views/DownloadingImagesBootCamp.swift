//
//  DownloadingImagesBootCamp.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 26.07.23.
//

import SwiftUI

struct DownloadingImagesBootCamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.imagesArray) {
                    ImageLoadingRowView(photo: $0)
                }
            }
            .navigationTitle("Another round")
            .listStyle(.plain)
            
        }
    }
}

struct DownloadingImagesBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootCamp()
    }
}
