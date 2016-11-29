//
//  Communications.swift
//  TMDBPriv
//
//  Created by Isay González Lázaro on 24/11/16.
//  Copyright © 2016 Isay González Lázaro. All rights reserved.
//
let APIKey = "f6329b3159eb0e1387541111fe97ce48"
let APIURLPrefix = "https://api.themoviedb.org/3"
let imageURLPrefix = "https://image.tmdb.org/t/p"
import UIKit
import Alamofire
import SystemConfiguration
import ReachabilitySwift
fileprivate var requestURLString = "\(APIURLPrefix)/discover/movie?api_key=\(APIKey)"
fileprivate var parameters: Dictionary<String, AnyObject> = [
    "api_key": APIKey as AnyObject,
    "sort_by": "popularity.desc" as AnyObject
]
class Communications: NSObject {
    
    var request : Alamofire.Request? = nil // main request used by child classes
    
    
    //##########################################
    //cancel current request
    //##########################################
    func cancelRequest()
    {
        
        if (self.request != nil)
        {
            self.request?.cancel()
        }
    }
    
    //##########################################
    //disable information cache
    //##########################################
    func disableCache()
    {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.memoryCapacity=0
    }
    //##########################################
    //Check for internet connection
    //##########################################
    func inet() -> Bool
    {
        let check:Reachability=Reachability.init()!
        print (check.isReachable)
        return check.isReachable
        
    }
    
}




