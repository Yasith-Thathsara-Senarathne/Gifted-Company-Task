//
//  FilmList+APIRouter.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-19.
//

import Foundation
import Moya

extension FilmListViewModel {
    enum APIRouter {
        case films
    }
}

extension FilmListViewModel.APIRouter : APIBaseRouter {
    var path: String {
        switch self {
        case .films:
            return "films"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .films:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .films:
            return .requestPlain
        }
    }
}
