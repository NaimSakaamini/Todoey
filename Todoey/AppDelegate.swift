//
//  AppDelegate.swift
//  Todoey
//
//  Created by Naim Sakaamini on 2019-05-03.
//  Copyright © 2019 Naim Sakaamini. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       //print(Realm.Configuration.defaultConfiguration.fileURL)
        
       
        //initialize realm
        do{
            _ = try Realm()
            
        } catch {
            print("error initializing real \(error)")
        }
        return true
    }
    
}

