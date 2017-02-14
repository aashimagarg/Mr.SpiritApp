//
//  TwitterViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import BDBOAuth1Manager



class TwitterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tweets: [Tweet]!
    
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //constructing cell properties
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        //setting up warning view
        warningView.backgroundColor = UIColor(hexString: "#9E9EA5")
        self.warningView.alpha = 0
        
        //loading tweets
        TwitterClient.sharedInstance.trendingTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            UIView.animate(withDuration: 1.0, animations: {
                self.warningView.alpha = 0
                }, completion: nil)
        }) { (error: NSError) -> () in
            print("error: \(error.localizedDescription)")
            UIView.animate(withDuration: 1.0, animations: {
                self.warningView.alpha = 1
                }, completion: nil)
        }
        
        //allowing slide to refresh
        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(TwitterViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        TwitterClient.sharedInstance.trendingTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: NSError) -> () in
            print("error: \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCreate(_ sender: AnyObject) {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            
            return tweets.count
            
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //constructing cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        
        let tweet = tweets[indexPath.row]
        
        //data is visible in cell
        cell.tweetMessage.text = tweet.text
        cell.screenLabel.text = "@\(tweet.screenLabel!)"
        cell.profileAvatar.setImageWith(tweet.profileUrl! as URL)
        cell.nameLabel.text = tweet.nameLabel
        
        
        //formatting time stamp
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        cell.timeStamp.text = formatter.string(from: tweet.timestamp! as Date)
        
        return cell
    }
    
    //function to execute refresh
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        TwitterClient.sharedInstance.trendingTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            UIView.animate(withDuration: 1.0, animations: {
                self.warningView.alpha = 0
                }, completion: nil)
            self.tableView.reloadData()
            print("refreshed")
        }) { (error: NSError) -> () in
            print("error: \(error.localizedDescription)")
            UIView.animate(withDuration: 1.0, animations: {
                self.warningView.alpha = 1
                }, completion: nil)
        }
        refreshControl.endRefreshing()
    }
    
    @IBAction func onOpen(_ sender: AnyObject) {
        
        let appURL = URL(string: "twitter://earch?q=%23MrSpirit2016&src=typd")
        let webURL = URL(string: "https://twitter.com/search?q=%23MrSpirit2016&src=typd")
        
        let application = UIApplication.shared
       
        
        if application.canOpenURL(appURL!) {
            application.openURL(appURL!)
        } else {
            application.openURL(webURL!)
        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
