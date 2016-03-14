//
//  RunKeeperClient.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/8/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import p2_OAuth2
import SwiftyJSON

public class RunKeeperClient: Client {
    static public let sharedInstance = RunKeeperClient()
    
    let baseURL:String = "https://api.runkeeper.com"
    
    init(){
        let resourcePath = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist")
        let keyDict = NSDictionary(contentsOfFile: resourcePath!) as? Dictionary<String,String>
        let clientId = keyDict?["RunKeeperClientId"]!
        let clientSecret = keyDict?["RunKeeperClientSecret"]!
        let settings = [
            "client_id": clientId!,
            "client_secret": clientSecret!,
            "authorize_uri": "https://runkeeper.com/apps/authorize",
            "token_uri": "https://runkeeper.com/apps/token",
            "redirect_uris": ["fitnessapi://authorization"],
            "secret_in_body": true
        ] as OAuth2JSON
        
        super.init(childSettings: settings)
    }
    
    /**
     Fetch activities from api.
     */
    override public func fetchActivities(params: [String : String] = Dictionary<String, String>(), completionHandler: (Array<Activity>, NSError?) -> Void) {
        
        let activityPath:String = "\(self.baseURL)/fitnessActivities"
        
        //set accept header and content type
        print("keeper fetch")
        
        self.oauth2.authorize() //not sure if this is the best way...
        self.oauth2.request(.GET, NSURL(string: activityPath)!, headers:
            [ "Accept": "application/vnd.com.runkeeper.fitnessactivityfeed+json",
                "Content-Type": "application/vnd.com.runkeeper.fitnessactivity+json"
            ])
            .validate()
            .responseJSON { (response) -> Void in
                switch response.result{
                case .Success(let value):
                    let json = JSON(value)
                    let jsonArray = json["items"].arrayValue
                    let activities = RunKeeperActivity.mapListOfRunKeeperJSON(jsonArray)
                    
                    completionHandler(activities, nil)

                    break
                case .Failure(let error):
                    print(error)
                    break
                }
        }
    }

}