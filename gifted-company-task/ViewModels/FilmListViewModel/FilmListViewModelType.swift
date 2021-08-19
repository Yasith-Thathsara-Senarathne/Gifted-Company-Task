//
//  FilmListViewModelType.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-19.
//

import Foundation
import RxSwift
import RealmSwift

protocol FilmListViewModelType {
    var data: Observable<Results<FilmDBModel>?> { get }
    
    var loading: Observable<(Bool, type: LoadingType)> { get }
    
    func fetchData()
}
