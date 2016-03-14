//
//  APIManager.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/4/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import FitnessAPI

class APIManager {
    static let sharedInstance = APIManager()
    
//    var deviceConnected
    var currentAPIClient: Client?
    
    // api manager needs to know what device the user is connected to or
    // is going to connect to
    
    // APIManager's task is to delicate work to the appropriate api library. THAT IS IT
    
    init(){
        // first need to find out which device or app the user is using
        // get from Firebase
        // set the appropriate currentAPIClient
        
        
        
    }
    
    func handleURL(url:NSURL) {
        currentAPIClient?.handleRedirectURL(url)
    }
    
    func deauthorize(){
        currentAPIClient?.deauthorize()
    }
    
    /**
        Should probably only be called when user is authorizing for the first time.
     */
    func authorize(deviceConnected:Device = .NoDevice, completionHander:(() -> Void)?){
        switch deviceConnected{
        case .Strava:
            if currentAPIClient == nil {
                currentAPIClient = StravaClient.sharedInstance as Client
            }
        break
        case .Fitbit:
            if currentAPIClient == nil {
//                currentAPIClient = FitbitClient.sharedInstance as Client
            }
        break
        case .Runkeeper:
            if currentAPIClient == nil {
                currentAPIClient = RunKeeperClient.sharedInstance as Client
            }
        break
        default:
            //set the currentAPIClient to the one store in Firebase
        break
        }
        
        currentAPIClient?.authorize(completionHander)
    }
    
    func fetchActivities(completionHandler: ((Array<Activity>, NSError?) -> Void)){
        currentAPIClient?.fetchActivities(completionHandler: completionHandler)
    }
}