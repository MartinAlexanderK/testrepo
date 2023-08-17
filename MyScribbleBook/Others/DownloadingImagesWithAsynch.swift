//
//  DownloadingImagesWithAsynch.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 24.07.23.
//

import SwiftUI




//MARK: - Services

class DownloadingImagesWithAsynchDataService {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func handleResponse(data:Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else{
            return nil
        }
        return image
    }
    
    func downloadWithAsynch() async throws -> UIImage? {
        do {
         let (data, response) =  try await URLSession.shared.data(from: url, delegate: nil)
         return handleResponse(data: data, response: response)
        } catch  {
            throw error
        }
    }
}



//MARK: - ViewModel

class DownloadingImagesWithAsynchViewModel : ObservableObject {
    
    
    let service = DownloadingImagesWithAsynchDataService()
    
    @Published var image : UIImage? = nil
    
    func fetchImage() async {
        
        let image = try? await service.downloadWithAsynch()
        await MainActor.run(body: {
            self.image = image
        })
    }
    
    
}

//MARK: - Body

struct DownloadingImagesWithAsynch: View {
    
    @StateObject var vm = DownloadingImagesWithAsynchViewModel()
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
        }
        .task {
            await vm.fetchImage()

        }
    }
}















struct DownloadingImagesWithAsynch_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesWithAsynch()
    }
}
