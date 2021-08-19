//
//  UIColor+Extension.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-19.
//

import Foundation
import UIKit

extension UIColor{
    
    class var erieBlack:UIColor{
        return .init(.erieBlack)
    }
    
    class var pacificBlue: UIColor {
        return .init(.pacificBlue)
    }
    
    class var woodSmoke: UIColor {
        return .init(.woodSmoke)
    }
    
    class var malachiteGreen: UIColor {
        return .init(.malachiteGreen)
    }
    
    class var ashWhite: UIColor {
        return .init(.ashWhite)
    }
}

extension UIColor {
    convenience init(_ name:ColorNames) {
        self.init(named:name.rawValue)!
    }
}
