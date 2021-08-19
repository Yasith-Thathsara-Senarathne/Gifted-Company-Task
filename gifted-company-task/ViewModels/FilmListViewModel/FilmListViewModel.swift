//
//  FilmListViewModel.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-19.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import Moya

struct FilmListViewModel: FilmListViewModelType {
    private let apiProvider = MoyaProvider<APIRouter>()
    private let dbService: FilmDBServiceType = FilmDBService()
    
    var data: Observable<Results<FilmDBModel>?> {
        return Observable.just(dbService.films)
    }
    
    var loading: Observable<(Bool, type: LoadingType)> {
        loadingSubject.asObservable()
    }
    private let loadingSubject = PublishSubject<(Bool, type: LoadingType)>.init()
    
    var dataCount = BehaviorRelay<Int>.init(value: 0)
    
    func fetchData() {
        let loadingType: LoadingType = dataCount.value == 0 ? .main : .background
        loadingSubject.onNext((true, loadingType))
        
        _ = apiProvider.rx.request(.films)
            .map([FilmDataModel].self, atKeyPath: "results")
            .map { $0.map { $0.convertToDBModel } }
            .asObservable()
            .do(onDispose: {
                loadingSubject.onNext((false, loadingType))
            })
            .catchErrorJustReturn([])
            .subscribe(onNext: {
                dbService.createFilmList($0)
            })
    }
}
