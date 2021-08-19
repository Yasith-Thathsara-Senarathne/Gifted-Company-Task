//
//  FilmsModel.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import Foundation

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
}
