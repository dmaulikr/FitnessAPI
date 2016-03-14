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
    var id:String?
    
    /**
        running, cycling, workout
        only care about running for now
    */
    var type:String?
    
    /**
        Total disntance in meters
    */
    var distance: Float? //meters
    
    /**
        Total running time in seconds
    */
    var time: Int?
    
    /**
        min/km or min/mile
    */
    var pace: Float? //min/km  or min/mile
    
    /**
        UTC time representation from NSDate
        Ex. 2013-08-24 00:04:12 +0000
    */
    var startDate: String?
    
    /**
        time zone abbreviation. 
        Ex. EDT -> "Eastern Daylight Time"
    */
    var timeZone: String?
    
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