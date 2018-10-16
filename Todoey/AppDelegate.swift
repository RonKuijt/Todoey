//
//  AppDelegate.swift
//  Todoey
//
//  Created by Ron on 03/10/2018.
//  Copyright © 2018 Ron. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do {
            let realm = try Realm()
        } catch {
            print ("Error initializing new Realm,\(error)")
        }
        
        return true
    }
}
