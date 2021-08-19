//
//  FilmDBServiceType.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import Foundation
import RealmSwift

protocol FilmDBServiceType {
    var films: Results<FilmDBModel>? { get }
    
    func createFilmList(_ films: [FilmDBModel])
}
