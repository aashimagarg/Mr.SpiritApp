//
//  Tweet.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 4/12/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var retweeted: Bool?
    var favorited: Bool?
    var nameLabel: String?
    var screenLabel: String?
    var profileUrl: NSURL?
    
    init(dictionary: NSDictionary){
        
        text = dictionary["text"] as? String
        nameLabel = dictionary["user"]!["name"] as? String
        screenLabel = dictionary["user"]!["screen_name"] as? String
        retweeted = dictionary["retweeted"] as? Bool
        favorited = dictionary["favorited"] as? Bool
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        let profileUrlString = (dictionary["user"]!["profile_image_url_https"] as? String)
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        
        //formatting a timestamp in a readable manner
        let timestampString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        
        if let timestampString = timestampString {
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        //iterate through all dictionaries to create tweet and add to array of tweets
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        
        return tweets
    }
}

