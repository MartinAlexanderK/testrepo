//
//  ContinuationBootCamp.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 25.07.23.
//

import SwiftUI


class ContinuationBootCampNetorkManager {
    
    func getData(url:URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            return data
        } catch  {
            throw error
        }
    }
    
    func getData2(url:URL) async throws -> Data {
        return try await withCheckedThrowingContinuation({ continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                }
                else if let error = error {
                    continuation.resume(throwing: error)
                }
                else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        })
        }
    
    
    func getHeartImageFromDataBase(completionHandler: @escaping (_ image: UIImage) -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func getHeartImageFromDataBase() async -> UIImage {
        return await withCheckedContinuation({ continuation in
            getHeartImageFromDataBase { image in
                continuation.resume(returning: image)
            }
        })
    }
    
}






class ContinuationBootCampViewModel : ObservableObject {
    
    let networkManager = ContinuationBootCampNetorkManager()
    
    @Published var image : UIImage? = nil
    
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/300") else {return}
        do {
            let data = try await networkManager.getData(url: url)
            
            if let image = UIImage(data: data){
                await MainActor.run(body: {
                    self.image = image
                })
            }
        } catch  {
            print(error)
        }
    }
    
    
    
    
    func getHeartImage() async  {
        self.image = await networkManager.getHeartImageFromDataBase()
    }
    
    
}






struct ContinuationBootCamp: View {
    
    @StateObject var viewModel = ContinuationBootCampViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .task {
           await viewModel.getImage()
        }
    }
}

struct ContinuationBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ContinuationBootCamp()
    }
}
