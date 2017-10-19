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
    FirebaseApp.configure()
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
}

