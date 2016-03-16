//
//  Activity.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/5/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Activity {
    /**
        The id of the activity
        Ex. Strava_23942349
    */
    public var id:String?
    
    /**
        running, cycling, workout
        only care about running for now
    */
    public var type:String?
    
    /**
        Total disntance in meters
    */
    public var distance: Float? //meters
    
    /**
        Total running time in seconds
    */
    public var time: Int?
    
    /**
        min/km or min/mile
    */
    public var pace: Float? //min/km  or min/mile
    
    /**
        UTC time representation from NSDate
        Ex. 2013-08-24 00:04:12 +0000
    */
    public var startDate: String?
    
    /**
        time zone abbreviation. 
        Ex. EDT -> "Eastern Daylight Time"
    */
    public var timeZone: String?
    
    init(json:JSON){
        mapToModel(json)
    }
    
    /**
        Map json response to the appropriate variable.
        Method needs to be overrided by child class to implement special logic
     */
    func mapToModel(json:JSON){
        fatalError("child need to override this method")
    }
}