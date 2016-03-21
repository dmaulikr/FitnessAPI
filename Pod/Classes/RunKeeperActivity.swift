//
//  RunKeeperActivity.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/8/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import SwiftyJSON

public class RunKeeperActivity: Activity{
    override func mapToModel(json: JSON) {
        //start_time string  Ex. Sat, 16 Aug 2014 23:57:24
        //utc_offset integer (for timezone) Ex. -4
        //total_distance double (meters)
        //duration double (seconds)
        //type Running
        //uri  use this for id
        
        self.distance = json["total_distance"].float
        self.time = json["duration"].int
        self.type = json["type"].string
        
        if let startTimeString = json["start_time"].string {
            if let utcOffset = json["utc_offset"].int {
                let timeZone:NSTimeZone = NSTimeZone(forSecondsFromGMT: utcOffset * 3600)
                
                // deal with time format
                let dateFormatter = NSDateFormatter()
                dateFormatter.timeZone = timeZone
                dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss"
                let date:NSDate = dateFormatter.dateFromString(startTimeString)!
                
                self.startDate = date.timeIntervalSince1970
                self.timeZone = timeZone.abbreviation
            }
        }
        
        // need to parse uri to get id
        if let uri = json["uri"].string {
            let splitString = uri.componentsSeparatedByString("/")
            self.id = "RunKeeper_\(splitString[2])"
        }
        
    }
    
    /**
     Take cares of Strava Activity JSONs and turn them into Activity model.
     */
    static public func mapListOfRunKeeperJSON(jsonArray:Array<JSON>) -> Array<Activity> {
        var activities: Array<Activity> = []
        
        for json in jsonArray {
            let activity:RunKeeperActivity = RunKeeperActivity(json: json)
            activities.append(activity as Activity)
        }
        
        return activities
    }


}
