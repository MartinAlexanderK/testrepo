//
//  NavigationstackCamp2.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 21.07.23.
//

import SwiftUI

struct NavigationstackCamp2: View {
    
    @State var path : [String] = []
    let fruits = ["Banana","Orange","Melon"]
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack (spacing: 40){
                    Spacer()
                    ForEach(fruits, id: \.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text("This is the \(fruit) way to handle things")
                            
                        }
                    }
                }
            }
            .navigationDestination(for: String.self) { fruit in
                MySecondView(value: fruit)
            }
        }
    }
}

struct NavigationstackCamp2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationstackCamp2()
    }
}

struct MySecondView : View {
    
    let value : String
    
    init(value : String) {
        self.value = value
    }
    
    var body: some View {
        
        Text("This is the value: \(value)")
        
        
    }
    
    
}
