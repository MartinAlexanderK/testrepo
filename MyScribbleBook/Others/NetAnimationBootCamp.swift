//
//  NetAnimationBootCamp.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 21.07.23.
//

import SwiftUI

struct NetAnimationBootCamp: View {
    
    @State var animation1: Bool = false
    @State var animation2 : Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Button("Button1") {
                    animation1.toggle()
                }
                Button("Button1") {
                    animation2.toggle()
                }
                
                ZStack {
                    Rectangle()
                        .frame(width: 150,height: 150)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity,alignment: animation1 ? .leading : .trailing)
                        .background(Color.red)
                        .frame(maxHeight: .infinity, alignment: animation2 ? .bottom : .top)
                        .background(Color.secondary)
                }
                
            }
        }
        .animation(.spring(), value: animation1)
        .animation(.spring(response: 5, dampingFraction: 1, blendDuration: 1), value: animation2)
    }
}

struct NetAnimationBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        NetAnimationBootCamp()
    }
}
