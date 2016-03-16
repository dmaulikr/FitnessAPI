//
//  StravaClient.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/4/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import p2_OAuth2
import SwiftyJSON

public class StravaClient: Client {
    static public let sharedInstance = StravaClient()
    
    let baseURL:String = "https://www.strava.com/api/v3"
    
    init(){
        super.init(childSettings: nil)
        // initialize clientId and clientSecrent form Keys.plist
        // just a precaution since code is stored on open github
        let resourcePath = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist")
        let keyDict = NSDictionary(contentsOfFile: resourcePath!) as? Dictionary<String,String>
        let clientId = keyDict?["StravaClientId"]!
        let clientSecret = keyDict?["StravaClientSecret"]!
                
        let settings = [
            "client_id": clientId!,
            "client_secret": clientSecret!,
            "authorize_uri": "https://www.strava.com/oauth/authorize",
            "token_uri": "https://www.strava.com/oauth/token",
            "redirect_uris": ["fitnessapi://authorization"],
            "secret_in_body": true
            ] as OAuth2JSON
        
        self.oauth2 = OAuth2CodeGrantNoTokenType(settings: settings)
    }
    
    /**
        Fetch activities from api.
    */
    override public func fetchActivities(params: [String : String] = Dictionary<String, String>(), completionHandler: (Array<Activity>?, NSError?) -> Void) {
        
        let activityPath:String = "\(self.baseURL)/athlete/activities"
        
        self.oauth2.authorize() //not sure if this is the best way...
        self.oauth2.request(.GET, NSURL(string: activityPath)!)
            .validate()
            .responseJSON { (response) -> Void in
                switch response.result {
                case .Success(let value):
                    let json = JSON(value)
                    let jsonArray = json.arrayValue
                    let activities = StravaActivity.mapListOfStravaJSON(jsonArray)
                    completionHandler(activities, nil)
                    break
                case .Failure(let error):
                    completionHandler(nil, error)
                    print(error)
                    break
                }
        }
    }


}