//
//  AnimationBootCamp.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 21.07.23.
//

import SwiftUI


struct AnimationBootCamp : View {
    
    @State private var animate1 : Bool = false
    @State private var animate2 : Bool = false
    
    
    var body: some View {
        
        ZStack {
            VStack {
                Button("Button 1") {
                    animate1.toggle()
                }
                Button("Button 2") {
                    animate2.toggle()
                }
                ZStack {
                    Rectangle()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity,alignment: animate1 ? .leading : .trailing)
                        .background(Color.red)
                    
                        .frame(maxHeight: .infinity, alignment: animate2 ? .top : .bottom)
                        .background(Color.blue)
                                        
                }
            }
        }
        .animation(.spring(), value: animate1)
        .animation(.easeOut(duration: 5), value: animate2)
        
    }
}

struct AnimationBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBootCamp()
    }
}

//struct AnimationBootCamp: View {
//
//    @State private var animate1 : Bool = false
//    @State private var animate2 : Bool = false
//
//
//    var body: some View {
//        ZStack {
//            VStack {
//                Button("Action1") {
//                    animate1.toggle()
//                }
//
//                Button("Action2") {
//                    animate2.toggle()
//                }
//
//                ZStack {
//                    Rectangle()
//                        .frame(width: 100,height: 100)
//                        .frame(maxWidth: .infinity, alignment: animate1 ? .leading : .trailing)
//                        .background(Color.colorTheme.accent)
//
//                        .frame(maxHeight: .infinity, alignment: animate2 ? .top : .bottom)
//                        .background(Color.colorTheme.red)
//
//                }
//
//            }
//        }
//        .animation(.spring(), value: animate1)
//        .animation(.easeInOut(duration: 4), value: animate2)
//    }
//}
//
//struct AnimationBootCamp_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimationBootCamp()
//    }
//}
