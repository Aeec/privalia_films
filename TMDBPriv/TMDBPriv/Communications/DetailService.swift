//
//  DetailService.swift
//  TMDBPriv
//
//  Created by Isay González Lázaro on 27/11/16.
//  Copyright © 2016 Isay González Lázaro. All rights reserved.
//

import UIKit
import Alamofire
class DetailService: Communications {
    
    //##########################################
    //load a film detail
    //id -> film identifier
    //##########################################
    
    func obtainFilmDetail(id: Int, _ done: @escaping (Any) -> Void, fail: @escaping (NSError?) -> Void) {
        if (self.inet() == false)//check for internet connection
        {
            fail(NSError(domain: "error", code: -1, userInfo: nil))
            return
        }
        self.disableCache() //disable cache data
        self.request = Alamofire.request("\(APIURLPrefix)/movie/\(id)?api_key=\(APIKey)&language=es-ES", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if(response.response?.statusCode == 200) //check if statusCode is correct
                {
                    if response.result.value != nil { //check if we have result
                        
                        done(response.result.value) //send result
                    }
                    
                }else if let error = response.result.error{ //check what kind of error we have
                    
                    //we have an error from the service
                    fail(error as NSError?) // send error
                } else
                {
                    //we have received a wrong response
                    
                    
                    fail (NSError(domain: "error", code: -1, userInfo: nil)) // send a generic error
                }
        }
    }
    
    
}
