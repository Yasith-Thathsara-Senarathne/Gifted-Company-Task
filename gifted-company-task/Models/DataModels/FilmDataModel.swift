//
//  FilmsModel.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import Foundation
import RealmSwift

struct FilmDataModel: Decodable {
    var title: String
    var episodeId: Int
    var openingCrawl: String
    var director: String
    var producer: String
    var releaseDate: String
    var characters: [String]
    
    private enum CodingKeys: String, CodingKey {
        case title, director, producer, characters
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case releaseDate = "release_date"
    }
    
    var convertToDBModel: FilmDBModel {
        let object = FilmDBModel()
        object.title = title
        object.episodeId = episodeId
        object.openingCrawl = openingCrawl
        object.director = director
        object.producer = producer
        object.releaseDate = releaseDate
        object.characters.append(objectsIn: characters)
        
        return object
    }
}
