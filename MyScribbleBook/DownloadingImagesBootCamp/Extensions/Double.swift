//
//  Double.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 25.07.23.
//

import Foundation


extension Double {
    
    
      var percentageFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        return formatter
    }
    
     func convertToPercent() -> String {
        let number = NSNumber(value: self)
        return percentageFormatter.string(from: number) ?? "0.0%"
        
        
        
    }
    
}
