//
//  AppDelegate.swift
//  Aliyah Media
//
//  Created by Nitin Bhatia on 10/01/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import LinkedinSwift
import TwitterKit
import TwitterCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
//        let sb = UIStoryboard(name: "Event", bundle: nil)
//        let vc = sb.instantiateInitialViewController()
//        window?.rootViewController = vc
//        window?.makeKeyAndVisible()
//        
        if let lang = UserDefaults.standard.value(forKey: "appLanguage"){
            UserDefaults.standard.set(lang, forKey: "appLanguage")
        } else {
            UserDefaults.standard.set("en", forKey: "appLanguage")
        }
        
        TWTRTwitter.sharedInstance().start(withConsumerKey:"GNxNueqP40Ql7yqS2OOzFANeS", consumerSecret:"xV5h9UwQSRcsOAK80aCH6sixVZLZ3XeApQlc535YHLrN9wKVhS")

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }

//    func application(_ application: UIApplication,
//                     openURL url: NSURL,
//                     sourceApplication: String?,
//                     annotation: AnyObject) -> Bool {
//
//        // Linkedin sdk handle redirect
//        if LinkedinSwiftHelper.shouldHandle(url as URL) {
//            return LinkedinSwiftHelper.application(application,
//                                                   open: url as URL as URL,
//                                                   sourceApplication: sourceApplication,
//                                                   annotation: annotation
//            )
//        }
//
//        return false
//    }
}

