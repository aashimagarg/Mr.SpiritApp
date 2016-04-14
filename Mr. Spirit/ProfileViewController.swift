//
//  ProfileViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import Firebase
import Braintree

class ProfileViewController: UIViewController, BTDropInViewControllerDelegate {
    var braintreeClient: BTAPIClient?

    @IBOutlet weak var bioHeader: UILabel!
    @IBOutlet weak var modelImage: UIImageView!
    @IBOutlet weak var bioText: UILabel!
    @IBOutlet weak var voteButton: UIButton!
    @IBOutlet weak var donateButton: UIButton!
    var candidate:Candidate? = Candidate()
    var ref = Firebase(url:"httvar//mrspirit2016.firebaseio.com/candidates/")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Disable vote button if user has voted
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.boolForKey("hasVoted")) {
            voteButton.setTitle("Voted", forState: .Normal)
            voteButton.backgroundColor = UIColor(hexString: "#9E9EA5")
            voteButton.enabled = false
        }
        
        getCandidateInfo()

        // Braintree set-up
        let clientTokenURL = NSURL(string: "https://gatnaofft8.execute-api.us-east-1.amazonaws.com/sandbox/token")!
        let clientTokenRequest = NSMutableURLRequest(URL: clientTokenURL)
        clientTokenRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        NSURLSession.sharedSession().dataTaskWithRequest(clientTokenRequest) { (data, response, error) -> Void in
            print(error)
            // Handle reiturned JSON
            var clientToken:String?
            getData: do {
                if (data == nil){
                    break getData
                }
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                let jsonDataDict = jsonData as? [String:String]
                clientToken = jsonDataDict!["client_token"]
            } catch let error as NSError {
                print(error)
            }
            
            if clientToken != nil {
                self.braintreeClient = BTAPIClient(authorization: clientToken!)
            }
        }.resume()
        
    }
    
    func getCandidateInfo(){
        // Get candidate image
        modelImage.image = self.candidate?.detailPhoto
        
        // Get candidate bio header
        bioHeader.text = self.candidate!.name
        
        // Candidate bio, justfied
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        let attributedString = NSAttributedString(string: self.candidate!.bio, attributes: [NSParagraphStyleAttributeName: paragraphStyle, NSBaselineOffsetAttributeName: NSNumber(float: 0)])
        bioText.attributedText = attributedString
    }
    
    @IBAction func voteBttnClicked(sender: AnyObject) {
        // Display UIAlertView
            // Call UIAlertView func
        
        
        ////// Run in UIAlertView if click "continue"
        // Run vote as transaction to update vote count
        let upvotesRef = Firebase(url: "httvar//mrspirit2016.firebaseio.com/candidates/\(candidate!.name)/votes")
        upvotesRef.runTransactionBlock({
            (currentData:FMutableData!) in
            var value = currentData.value as? Int
            if (value == nil) {
                value = 0
            }
            currentData.value = value! + 1
            print(currentData)
            print(currentData.value)
            return FTransactionResult.successWithValue(currentData)
        })
        
        // Update button
        voteButton.setTitle("Voted", forState: .Normal)
        voteButton.backgroundColor = UIColor(hexString: "#9E9EA5")
        voteButton.enabled = false
        
        // Disable all others voting
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasVoted")

    }
    
    @IBAction func donateButtonClicked(sender: AnyObject) {
        if (braintreeClient != nil){
            tappedMyPayButton()
        }
        // TODO: else (UIAlertView) "Please check your internet connection and try again"
    }
    
    func getVoteCount(){
        // Votes
        ref = ref.childByAppendingPath(candidate!.name)
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            let votes = (snapshot.value.objectForKey("votes") as? Int)!
            self.candidate!.votes = votes
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    
    
    func dropInViewController(viewController: BTDropInViewController, didSucceedWithTokenization paymentMethod: BTPaymentMethodNonce) {
        // send payment
        postNonceToServer(paymentMethod.nonce)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dropInViewControllerDidCancel(viewController: BTDropInViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tappedMyPayButton(){
        let dropInViewController = BTDropInViewController(APIClient: braintreeClient!)
        dropInViewController.delegate = self
        
        // This is where you might want to customize your view controller (see below)
        
        // The way you present your BTDropInViewController instance is up to you.
        // In this example, we wrap it in a new, modally-presented navigation controller:
        dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Cancel,
            target: self, action: #selector(ProfileViewController.userDidCancelPayment))
        dropInViewController.navigationItem.leftBarButtonItem?.tintColor = UIColor(hexString: "FFFFFF")
        let navigationController = UINavigationController(rootViewController: dropInViewController)
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func userDidCancelPayment(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postNonceToServer(paymentMethodNonce: String) {
        let paymentURL = NSURL(string: "https://gatnaofft8.execute-api.us-east-1.amazonaws.com/sandbox/checkout")
        let request = NSMutableURLRequest(URL: paymentURL!)
        
        // Dictionary of things to pass in body
        let body_dict: [String: String] = ["nonce": paymentMethodNonce, "amount": "11.11"]
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(body_dict, options: NSJSONWritingOptions.PrettyPrinted)
            request.HTTPBody = jsonData
            request.HTTPMethod = "POST"
        } catch let error as NSError {
            print(error)
        }
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
            print(response)
            }.resume()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
