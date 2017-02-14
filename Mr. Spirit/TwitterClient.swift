//
//  TwitterClient.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 4/12/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "NeIGiqZAMIBB7jbFtt3cEZFPS"
let twitterConsumerSecret = "WLBuJPNXbjUvrBJOepNelGDvYoQn8Dni1jLWIcwajuYreq2lbT"
let twitterBaseURL = URL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance!
    }
    
    func trendingTimeline(_ success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        
        let params = ["result_type" : "recent" , "count" : "100"]
        
        get("1.1/search/tweets.json?f=tweets&q=%23MrSpirit2016&src=typd", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            //setting initial index for dictionary
            let dictionaries = response!["statuses"] as! [NSDictionary]
            
            //print information from each tweet
            for dict in dictionaries {
                print("\(dict["user"]!["name"]!)")
                print("\(dict["user"]!["screen_name"]!)")
                print("\(dict["user"]!["profile_image_url_https"]!)")
                print("\(dict["text"]!)")
                print("\(dict["retweet_count"]!)")
                print("\(dict["favorite_count"]!)")
                
            }
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: URLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    
    
    
}
