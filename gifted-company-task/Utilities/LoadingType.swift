//
//  LoadingType.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-19.
//

import Foundation

enum LoadingType {
    case main
    case background
    
    var rawValue: Int {
        switch self {
        case .main:
            return 0
        case .background:
            return 1
        }
    }
}

extension LoadingType: Equatable {
    
}
