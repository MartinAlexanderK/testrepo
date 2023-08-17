//
//  OnAppearViewModifier.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 08.08.23.
//

import Foundation
import SwiftUI


struct OnAppearViewModifier: ViewModifier {
    @State private var didAppear: Bool = false
    let perform : (()->Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if !didAppear {
                    perform?()
                    didAppear = true
                }
            }
    }
}

extension View {
    func onFirstAppear(perform: (()->Void)?) -> some View {
        modifier(OnAppearViewModifier(perform: perform))
    }
}
