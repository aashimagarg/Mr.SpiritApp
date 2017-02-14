//
//  AppDelegate.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import SwiftHEXColors
import Firebase
import Braintree
import BDBOAuth1Manager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        UINavigationBar.appearance().barTintColor = UIColor(hexString: "#f9A643")
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor(hexString: "FFFFFF")!]
        
        UITabBar.appearance().barTintColor = UIColor(hexString: "#FBF9F9")
        UITabBar.appearance().tintColor = UIColor(hexString: "#f9A643")
        
        BTAppSwitch.setReturnURLScheme("com.codepath.Mr--Spirit.payments")
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.codepath.Mr--Spirit.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, sourceApplication:sourceApplication)
        }
        
        
        print(url.description)
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "NeIGiqZAMIBB7jbFtt3cEZFPS", consumerSecret: "WLBuJPNXbjUvrBJOepNelGDvYoQn8Dni1jLWIcwajuYreq2lbT")
        
        twitterClient?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            print("access token received")
            
            //fetching relevant tweets (#MrSpirit2016)
            let params = ["result_type" : "recent" , "count" : "100"]
            
            twitterClient?.get("1.1/search/tweets.json?f=tweets&q=%23MrSpirit2016&src=typd", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
                let tweets = response as! NSDictionary
                
                print(tweets)
                
                }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                    print("error: \(error.localizedDescription)")
            })
        }) { (error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
        }
        
        return false
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

