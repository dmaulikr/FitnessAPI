//
//  JSONAbleTest.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import FitnessAPI
import OHHTTPStubs
import XCTest

class JSOnAbleTests: XCTestCase{
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStravaActivityJSONAble(){
        //        https://www.strava.com/api/v3/athlete/activities
        let scheme = "https"
        let host = "www.strava.com"
        
        stub(isScheme(scheme) && isHost(host) && isPath("/api/v3/athlete/activities")) { _ in
            return OHHTTPStubsResponse(fileAtPath:OHPathForFile("stravaActivity.json", self.dynamicType)!, statusCode:200, headers:["Content-Type":"application/json"])
        }
        let expectation = self.expectationWithDescription("strava activity has arrived")
        
        StravaClient.sharedInstance.fetchActivities { (activities, error) -> Void in
            if let activities = activities{
                let firstActivity:Activity = activities[0]
                let dict = firstActivity.toDict()
                print("time \(firstActivity.startDate)")
                print(dict)
                
                expectation.fulfill()
            }
            
        }
        
        self.waitForExpectationsWithTimeout(1.5, handler: .None)
        
        OHHTTPStubs.removeAllStubs()
    }

    
    
}