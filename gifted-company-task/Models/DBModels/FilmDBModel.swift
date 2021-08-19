//
//  FilmDBModel.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import Foundation
import RealmSwift

@objcMembers
class FilmDBModel: Object {
    dynamic var id: String = UUID().uuidString
    dynamic var title: String = ""
    dynamic var episodeId: Int = 0
    dynamic var openingCrawl: String = ""
    dynamic var director: String = ""
    dynamic var producer: String = ""
    dynamic var releaseDate: String = ""
    dynamic var characters = List<String>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
