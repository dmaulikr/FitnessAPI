//
//  ViewController.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 03/14/2016.
//  Copyright (c) 2016 Jason Cheng. All rights reserved.
//

import UIKit
import FitnessAPI

class ViewController: UIViewController {

    @IBAction func authWithStrava(sender: AnyObject) {
        APIManager.sharedInstance.authorize(Device.Strava) { () -> Void in
            print("authorized")
        }
    }
    
    @IBAction func authWithRunKeeper(sender: AnyObject) {
        APIManager.sharedInstance.authorize(Device.Runkeeper) { () -> Void in
            print(Device.Runkeeper.rawValue + " authroized")
        }
    }
    
    @IBAction func fetchActivities(sender: AnyObject) {
        APIManager.sharedInstance.fetchActivities { (activities, error) -> Void in
            if error == nil {
                print(activities!.count)
            }
        }
    }
    
    //-------------------------
    @IBAction func unAuth(sender: AnyObject) {
        APIManager.sharedInstance.deauthorize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

