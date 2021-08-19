//
//  AppDelegate.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        migrateRealmSchemaVersion()
        window = UIWindow()
        let navController = UINavigationController.init(rootViewController: FilmListViewController())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}

import RealmSwift
//MARK:- Realm Schema Migration Related
extension AppDelegate {
    func migrateRealmSchemaVersion() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: GenericMethods().realmSchemaVersion,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < GenericMethods().realmSchemaVersion) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
    }
}

