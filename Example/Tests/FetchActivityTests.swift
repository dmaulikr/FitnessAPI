//
//  FetchActivityTest.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
import OHHTTPStubs
import FitnessAPI

class FetchActivityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStravaFetchActivitySuccess(){
//        https://www.strava.com/api/v3/athlete/activities
        let scheme = "https"
        let host = "www.strava.com"
        
        stub(isScheme(scheme) && isHost(host) && isPath("/api/v3/athlete/activities")) { _ in
            return OHHTTPStubsResponse(fileAtPath:OHPathForFile("stravaActivity.json", self.dynamicType)!, statusCode:200, headers:["Content-Type":"application/json"])
        }
        let expectation = self.expectationWithDescription("strava activity has arrived")
        
        StravaClient.sharedInstance.fetchActivities { (activities, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(activities, "activities should not be nil")
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(0.5, handler: .None)
        
        OHHTTPStubs.removeAllStubs()
    }
    
    func testStravaFetchActivityFailure(){
        let scheme = "https"
        let host = "www.strava.com"
        let expectedError:NSError = NSError(domain: "strava.com", code: 401, userInfo: .None)
        
        stub(isScheme(scheme) && isHost(host) && isPath("/api/v3/athlete/activities")) { _ in
            return OHHTTPStubsResponse(error: expectedError)
        }
        
        let expectation = self.expectationWithDescription("strava activity has arrived")
        
        StravaClient.sharedInstance.fetchActivities { (activities, error) -> Void in
            XCTAssertEqual(error, expectedError)
            XCTAssertNil(activities, "activities should be nil")
            
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(0.5, handler: .None)
        
        OHHTTPStubs.removeAllStubs()

    }
    
    func testRunKeeperFetchActivitySuccess(){
        let scheme = "https"
        let host = "api.runkeeper.com"
        
        stub(isScheme(scheme) && isHost(host) && isPath("/fitnessActivities")) { _ in
            print("**************")
            return OHHTTPStubsResponse(fileAtPath:OHPathForFile("runkeeperActivity.json", self.dynamicType)!, statusCode:200, headers:["Content-Type":"application/vnd.com.runkeeper.fitnessactivityfeed+json"])
        }
        let expectation = self.expectationWithDescription("runkeeper activity has arrived")
        
        RunKeeperClient.sharedInstance.fetchActivities { (activities, error) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(activities, "activities should not be nil")
            
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(0.5, handler: .None)
        
        OHHTTPStubs.removeAllStubs()
    }
    
    func testRunKeeperFetchActivityFailure(){
        let scheme = "https"
        let host = "api.runkeeper.com"
        let expectedError:NSError = NSError(domain: "api.runkeeper.com", code: 401, userInfo: .None)
        
        stub(isScheme(scheme) && isHost(host) && isPath("/fitnessActivities")) { _ in
            return OHHTTPStubsResponse(error: expectedError)
        }
        
        let expectation = self.expectationWithDescription("runkeeper activity has arrived")
        
        RunKeeperClient.sharedInstance.fetchActivities { (activities, error) -> Void in
            XCTAssertEqual(error, expectedError)
            XCTAssertNil(activities, "activities should be nil")
            
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(0.5, handler: .None)
        
        OHHTTPStubs.removeAllStubs()
        
    }

}
