//
//  FilmDBService.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import Foundation
import RealmSwift

struct FilmDBService: DBService, FilmDBServiceType {
    var films: Results<FilmDBModel>? {
        withRealm("Fetch all films") { db -> Results<FilmDBModel> in
            db.objects(FilmDBModel.self)
        }
    }
    
    func createFilmList(_ films: [FilmDBModel]) {
        withRealm("Create films") { db -> Void in
            try db.write {
                db.add(films, update: .modified)
            }
        }
    }
}
