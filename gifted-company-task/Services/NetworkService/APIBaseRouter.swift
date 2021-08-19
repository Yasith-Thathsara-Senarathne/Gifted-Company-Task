//
//  APIBaseRouter.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import Foundation
import Moya

public protocol APIBaseRouter: TargetType {}

extension APIBaseRouter {
    var baseURLString: String { return "https://swapi.dev/api/" }
    var url: URL {
        return URL.init(string: baseURLString)!
    }
    
    public var baseURL: URL { return url }
    
    public var task: Task {
        .requestPlain
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        let header: [String: String] = [:]
        return header
    }
}
