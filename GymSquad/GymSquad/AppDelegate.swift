//
//  AppDelegate.swift
//  GymSquad
//
//  Created by Angel Buenrostro on 3/19/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

  let primaryColor = UIColor(red: 210/255, green: 109/255, blue: 180/255, alpha: 1)
//let primaryColor = UIColor(red:1.00, green:0.37, blue:0.43, alpha:1.0)
//  let primaryColor = UIColor(red:0.93, green:0.00, blue:0.55, alpha:1.0)
//let secondaryColor = UIColor(red: 52/255, green: 148/255, blue: 230/255, alpha: 1)
//let secondaryColor = UIColor(red:1.00, green:0.76, blue:0.44, alpha:1.0)
    let secondaryColor = UIColor(red:0.99, green:0.40, blue:0.40, alpha:1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // START default_firestore
        FirebaseApp.configure()
        
        let db = Firestore.firestore()
        // END default_firestore
        
        //TEST DOWNLOAD
//        db.collection("users").whereField("userName", isEqualTo: "Angel").getDocuments { (snapshot, error) in
//            if error != nil {
//                print(error!)
//            } else {
//                for document in (snapshot?.documents)! {
//
//                    if let userName = document.data()["userName"] as? String {
//                        print(userName)
//                    }
//                }
//            }
//        }
        
//        let authListener = Auth.auth().addStateDidChangeListener { (auth, user) in
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//            if user != nil {
//                let controller = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
//                self.window?.rootViewController = controller
//                self.window?.makeKeyAndVisible()
//            } else {
//                let controller = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
//                self.window?.rootViewController = controller
//                self.window?.makeKeyAndVisible()            }
//        }
        
        print(db) // silence warning
        
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


}

