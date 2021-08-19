//
//  DBService.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import Foundation
import RealmSwift

protocol DBService {}

extension DBService {
    func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
      do {
        let realm = try Realm()
        return try action(realm)
      } catch let err {
        print("Failed \(operation) realm with error: \(err)")
        return nil
      }
    }
}
