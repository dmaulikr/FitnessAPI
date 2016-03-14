//
//  StravaActivity.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/5/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import SwiftyJSON

public class StravaActivity: Activity{
    override func mapToModel(json: JSON) {
        self.id = "strava_\(json["id"].int)"
        self.distance = json["distance"].float
        self.time = json["elapsed_time"].int
        
        
        // strava api date is in UTC format already, but we need to format it
        // so it looks like all the other dates from other apis
        let dateString = json["start_date"].stringValue
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let stravaDate:NSDate = dateFormatter.dateFromString(dateString)!
        
        // format time zone (GMT-08:00) America/Los_Angeles
        // don't need the (GMT-08:00) because it's not recognized by NSTimeZone
        let timeZoneString = json["timezone"].stringValue
        let timeZoneSplitString:[String] = timeZoneString.componentsSeparatedByString(" ")
        let zone:NSTimeZone = NSTimeZone(name: timeZoneSplitString[1])!
        
        self.startDate = String(stravaDate)
        self.timeZone = zone.abbreviation
    }
    
    /**
        Take cares of Strava Activity JSONs and turn them into Activity model.
     */
    static public func mapListOfStravaJSON(jsonArray:Array<JSON>) -> Array<Activity> {
        var activities: Array<Activity> = []
        
        for json in jsonArray {
            let activity:StravaActivity = StravaActivity(json: json)
            activities.append(activity as Activity)
        }
        
        return activities
    }
}