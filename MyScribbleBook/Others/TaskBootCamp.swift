//
//  TaskBootCamp.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 23.07.23.
//

import SwiftUI

class TaskBootCampViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do {
            guard let url = URL(string: "https://picsum.photos/2000") else {return}
            let(data,_) =  try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image = UIImage(data: data)
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootCampHomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                NavigationLink("Klick ME") {
                    TaskBootCamp()
                }
            }
        }
    }
}

struct TaskBootCamp: View {
    
    @StateObject private var vm = TaskBootCampViewModel()
    @State private var fetchImageTask: Task<(),Never>? = nil
    
    var body: some View {
        VStack (spacing: 40){
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 200)
            }
        }
        .task {
            await vm.fetchImage()
        }
    }
}

struct TaskBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskBootCampHomeView()
        }
    }
}
