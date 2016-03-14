//
//  OauthAlamofireExtension.swift
//  FitnessAPI
//
//  Created by Jason Cheng on 3/5/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import Alamofire
import p2_OAuth2

extension OAuth2 {
    public func request(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: Alamofire.ParameterEncoding = .URL,
        headers: [String: String]? = nil)
        -> Alamofire.Request
    {
        
        var hdrs = headers ?? [:]
        if let token = accessToken {
            hdrs["Authorization"] = "Bearer \(token)"
        }
        return Alamofire.request(
            method,
            URLString,
            parameters: parameters,
            encoding: encoding,
            headers: hdrs)
    }
}