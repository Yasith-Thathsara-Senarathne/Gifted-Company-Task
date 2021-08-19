//
//  CharacterModel.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import Foundation

struct CharacterDataModel: Decodable {
    var name: String
    var birthYear: String
    var gender: String
    
    private enum CodingKeys: String, CodingKey {
        case name, gender
        case birthYear = "birth_year"
    }
}
