//
//  Activity.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/5/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Activity{
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
        Unix time stamp. seconds since 1970
    */
    public var startDate: NSTimeInterval?
    
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
    
    /**
        Returns a dictionary with all the properties of this class.
        Helpful when need to save
    */
    public func toDict() -> [String:AnyObject] {
        return [
            "id": self.id!,
            "type": self.type!,
            "distance": self.distance!,
            "time": self.time!,
//            "pace": self.pace!,
            "startDate": self.startDate!,
            "timeZone": self.timeZone!
        ]
    }

}