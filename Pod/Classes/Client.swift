//
//  Client.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/6/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import p2_OAuth2

/**
    Parent class of all API clients
 */

public class Client {
    var oauth2:OAuth2CodeGrant!
    
    /**
        Initialize oauth2 with the OAuth2CodeGrant setting.
        override this if api needs a special type of authorization
     */
    init(childSettings: OAuth2JSON?){
        if let settings = childSettings {
            self.oauth2 = OAuth2CodeGrant(settings: settings)
        }
    }
    
    /**
        Attempt to authorize the user through the selected api client.
        OAuth2 also takes care of retrieving the access token
     
        - Parameter completionHandler: action to take after user has been authorized
     */
    public func authorize(completionHandler:(() -> Void)?){
        self.oauth2.onAuthorize = { parameters in
            print(parameters)
            completionHandler?()
        }
        self.oauth2.onFailure = { error in        // `error` is nil on cancel
            if nil != error {
                print(error)
            }
        }
        self.oauth2.authorize()
    }
    
    /**
        De authorize from api
        Use this if user wants to switch app or device
    */
    public func deauthorize(){
        self.oauth2.forgetTokens()
    }
    
    public func handleRedirectURL(url: NSURL){
        self.oauth2.handleRedirectURL(url)
    }
    
    /**
        Abstract method needs child to implement
        Fetch activities from api
    */
    public func fetchActivities(params: [String:String] = Dictionary<String,String>(), completionHandler: (Array<Activity>, NSError?) -> Void){
        fatalError("child class needs to implement this method")
    }
}