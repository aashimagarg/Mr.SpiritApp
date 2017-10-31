//
//  CandidatesViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

class CandidatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let cellId:String = "CandidateCell"
    
    // Load database
    //    var ref = Firebase(url:"httvar//mrspirit2016.firebaseio.com/candidates")
    var ref: DatabaseReference?
    
    var candidatesList = [Candidate]()
    var candidateNames = ["Arya Behroon", "Ben Hlousek", "Evan Welsh", "Joe Mason", "Johnathon Chang", "Miguel Martinez", "Mostefa Sheikhi", "Nick Spalding", "Thomas Le", "Uttam Eamani", "Zach Long", "Zachary Kornblau"]
    let candidateYear = ["Senior", "Junior", "Junior", "Sophomore", "Junior", "Senior", "Junior", "Senior", "Senior", "Junior", "Senior", "Senior"]
    var candidateOrgs = ["Camp Kesem", "One Note Stand, BHP", "Absolute Texxas", "Longhorn Hellraisers", "Texas THON", "Texas Blazers", "Texas Wranglers", "Texas 4000","Sailing Club", "Camp Texas", "Communication Council", "Longhorn Singers"]
    let bioText = [ "Oh, hello there. I'm Arya Behroon, and I just want to let you know that I think I did it again. I made you believe, we're more than just friends. Oh, baby. It might seem like a crush, but it doesn't mean... that I'm serious. 'Cause to lose all my senses, that is just so typically me. Oh baby baby. What I'm trying to say is, OOPS!... I did it again. Also, that I love sloths and identify with Olaf from Frozen.", "Twerkmaster and rightful husband of Shawn Mendes, Ben Hlousek is also a triple major in Business Honors, Finance, and Health and Society. When he isn't busy carrying out Financial Director duties for One Note Stand, trying to figure out why the U.S. healthcare system is more tragic than Katy Perry's comeback, or constantly attempting to riff like Tori Kelly, Ben loves to fangirl over Ru Paul's Drag Race and sporadically drive to Waco, Dallas, and Houston to avoid school and responsibilities for no apparent reason. He hopes you enjoy and look out for his sexy dance moves, modeling, vogueing, and singing tonight!", "Hey there! My name is Evan Welsh and I am an advertising major here at UT in the Texas Media program. I am a passionate member of the spirit group Absolute Texxas, a 2018 Texas 4000 for Cancer rider, and a Camp Texas alumnus. I intern at Fons PR, an entertainment PR company here in Austin where I get to do cool things like work with studios, attend film screenings, and promote movies around Austin. I love movies and the Oscars more than anything else (I joke that the Oscars are my favorite holiday but if I'm being honest, it's not a joke) and dream of winning one someday, though I'm not sure what I'd do to get one... I also enjoy going on hikes and being outside, hanging out with friends, exploring Austin, and traveling. I can't wait to participate in Mr. Spirit so come out to the show!", "Suh dudes! It’s me, not your average Joe. When I’m not putting out fires or eating at Kismet you can catch me writing sea shanties, cracking a cold Dr. Pepper with the boys, or raising some hell. They never made an Avatar The Last Airbender movie and I have no idea what you're talking about. Also the Map is hands down the best character in Dora the Explorer.", "Hi! My name is Johnathon Chang and I'm a junior studying biomedical engineering. At any given point in time, cash me eating my weight in food (getting thicc) or crying (because school)~HOW BOUT DAT?!? Hobbies include sleeping and dabbing vigorously. Beyonce, breakfast tacos, and a good laugh/smile are the way to my heart. Ily times a milly and hook'em for life!", "Hey, how’s it going? I’m Miguel and here’s a little haiku about me:\nOne room. Three siblings\nNow six more siblings. One dream.\nTen room house. One each.\nAlso if you’re ever down for a game of Mario Party hit me up because I’m so down for a 50 turn game...as long as I’m Yoshi", "Heyoooooo my name is Mostefa and here are a bunch of random facts about me! I have a cat named kitty that I love dearly. I come from the land of the purple sprite. I tend to think about really embarrassing things I did even when I was, like, seven over and over in my head until I visibly cringe. I aspire to paint but my pre-med schedule won't even allow me to eat a proper meal. I plan to simultaneously become a doctor and the next Kanye West in the future. Quote me on that!! Lastly, I love my family and I apologize for everything you're about to see tonight (if you were even able to come through). Also follow me on soundcloud!! Also shout out to the homie Dakota!!", "My life goals have recently switched over from aspiring to see UT have just one positive football season before I leave the 40 acres, to owning my very own commemorative speedway brick. I have a knack for finding the albino squirrel and still not getting an A. I am telling you now I can out eat you anytime, anyplace, especially if it's Cabo Bob's. I swim better than I run, or walk tbh; I'm still not sure if it's from all the early swim practices or all the concussions... \n\n\"10/10 Smile\" - Robonaut, 2016 \n\"I'm gonna call you tall Intern\" - Astronaut Jack D. Fischer, 2016 \n\"Are you free to FaceTime right now?\" - Bruce Weber, 11:57PM, 09/23/2017", "It's ya boy Thomas! I'm a free spirited guy with a love for the sun, cider, and singing in the shower. You can catch me on Lake Travis or biking around the boardwalk when I'm not cooking up an omelet at my co-op. Also, I'm always down to dance- so if you have a catchy ringtone (n'sync - bye bye bye) be prepared to witness me poppin' some moves.", "Hi, my name is Uttam Eamani. My claim to fame is that I've spent well over $1000 dollars at Pluckers, have successfully brought over 100 people to 888 (the best AND only pan-asian, Vietnamese-focused restaurant in Austin), have injured my ankle over 10 times in my lifetime, and have only 1 wish: that you support me throughout my journey to become Mr. Spurtz (that's how you spell it right?).", "Yes, hello. I’m Zach Long and I’m a student at Le Cordon Bleu in Austin and I want to be the next Chopped champion. I’m a Mary Berry enthusiast and have gone as the Pioneer Woman for Halloween twice. Also, my father is Guy Fieri. So, let’s take a trip to Flavortown, y’all. Bam!", "A senior Advertising and Economics major, Zachary Kornblau loves world peace, originality, and long walks along the Speedway bricks. When he's not in rehearsal or spending time with his Longhorn Singers friends, he spends the other 4 hours of his week doing homework or sleeping. Love you Mom and Dad!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Load candidate data
        loadCandidates()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
    }
    
    func loadCandidates(){
        var candidate = Candidate()
        var candidateDict:AnyObject
        var votes:Int = 0
        var amountRaised:Double = 0
        guard let ref = ref else {
            return
        }
        
        for index in 0...11 {
            let detailPic = UIImage(named: candidateNames[index])!
            let pic = UIImage(named: "sq-\(candidateNames[index])")!
            
            // Get number of current votes
            votes = candidate.getVoteCount(candidateNames[index], ref: ref)
            amountRaised = candidate.getAmountRaised(candidateNames[index], ref: ref)
            
            // Create candidate object
            candidate = Candidate(name: candidateNames[index], organization:candidateOrgs[index], bio:bioText[index], votes: votes, amountRaised:amountRaised, headshot: pic, detailPhoto: detailPic, year: candidateYear[index])
            
            // Add to candidate list
            candidatesList+=[candidate]
            
            // Save candidate ref
            candidateDict = candidate.toDict()
            candidate.saveRef(candidate.name, dict: candidateDict, ref: ref)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidatesList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! CandidateCell
        let candidate = candidatesList[indexPath.row]
        
        // Configure cell
        cell.nameLabel.text = candidate.name
        cell.orgLabel.text = candidate.organization
        cell.headshotImage.image = candidate.headshot
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileSegue" {
            let indexPath:IndexPath? = self.tableView!.indexPathForSelectedRow
            
            // Get the destination view controller
            let detailVC:ProfileViewController = segue.destination as! ProfileViewController
            
            self.tableView.deselectRow(at: indexPath!, animated: false)
            // Pass in the selected object to the new view controller
            let candidate:Candidate = candidatesList[indexPath!.row]
            detailVC.candidate = candidate
        }
    }
}
