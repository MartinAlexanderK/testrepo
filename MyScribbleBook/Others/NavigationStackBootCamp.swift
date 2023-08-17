//
//  NavigationStackBootCamp.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 23.07.23.
//

import SwiftUI

struct NavigationStackBootCamp: View {
    
    let fruits = ["Apple","Orange","Banana"]
    
    @State private var stackPath : [String]  = []
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            ScrollView {
                VStack(spacing:40) {
                    
                    
                    ForEach(fruits, id: \.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text(fruit)
                        }
                    }
                    
                }
            }
            .navigationDestination(for: String.self) { fruits in
                MySecondView(value: fruits)
            }
        }
    }
}






struct NavigationStackBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackBootCamp()
    }
}







struct MySecondScreen: View {
    
    let value : Int
    
    init(value: Int) {
        self.value = value
        print("INT FOR THE OTHER SCREEN: \(value)")
    }
    var body: some View {
        Text("Screen: \(value)")
    }
}
