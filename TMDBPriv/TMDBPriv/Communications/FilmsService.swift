//
//  FilmsService.swift
//  TMDBPriv
//
//  Created by Isay González Lázaro on 27/11/16.
//  Copyright © 2016 Isay González Lázaro. All rights reserved.
//

import UIKit
import Alamofire
class FilmsService: Communications {
    
    
    
    //##########################################
    //load most popular films from service
    //Page -> to control pagination
    //##########################################
    
    func loadPopular(page: Int, _ done: @escaping (Any) -> Void, fail: @escaping (NSError?) -> Void) {
        
        if (self.inet() == false)//check for internet connection
        {
            fail(NSError(domain: "error", code: -1, userInfo: nil))
            return
        }
        self.disableCache() //disable cache data
        
        self.request=Alamofire.request("\(APIURLPrefix)/discover/movie?api_key=\(APIKey)&sort_by=popularity.desc&include_adult=false&language=es-ES&include_video=false&page=\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                if(response.response?.statusCode == 200) // check if statusCode is correct
                {
                    if response.result.value != nil { // check if our response is nil
                        
                        done(response.result.value) // send response
                    }
                    
                }else if let error = response.result.error{ //check if we have received an error
                    
                    /*let err = error as NSError?
                     print( err?.code)*/
                    fail(error as NSError?)
                } else
                {
                    //we have received a wrong response
                    
                    
                    fail (NSError(domain: "error", code: -1, userInfo: nil)) //launch a generic error
                }
                
                
                
                
        }
        //  self.request?.cancel()
    }
    
    //##########################################
    //Search for films
    //Page -> to control pagination
    //Query -> string to search
    //##########################################
    
    func searchFilm(page: Int,query: String, _ done: @escaping (Any) -> Void, fail: @escaping (NSError?) -> Void) {
        if (self.inet() == false)//check for internet connection
        {
            fail(NSError(domain: "error", code: -1, userInfo: nil))
            return
        }
        self.disableCache() // disable cache data
        let string=query.replacingOccurrences(of: " ", with: "%20") //remove white spaces
        self.request = Alamofire.request("\(APIURLPrefix)/search/movie?api_key=\(APIKey)&page=\(page)&language=es-ES&query=\(string)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if(response.response?.statusCode == 200) // check if statusCode is correct
                {
                    if response.result.value != nil { //check response
                        
                        done(response.result.value) //send response
                    }
                    
                }else if let error = response.result.error{ // check if we have received an error
                    
                    
                    fail(error as NSError?) // send error
                } else
                {
                    //we have received a wrong response
                    
                    
                    fail (NSError(domain: "error", code: -1, userInfo: nil)) // send a generic error
                }
        }
    }
}
