//
//  CharacterDBModel.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import Foundation
import RealmSwift

@objcMembers
class CharacterDBModel: Object {
    dynamic var id: String = UUID().uuidString
    dynamic var name: String = ""
    dynamic var birthYear: String = ""
    dynamic var gender: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
