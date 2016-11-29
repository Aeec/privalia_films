//
//  DetailPresenter.swift
//  TMDBPriv

//  Created by Isay González Lázaro on 27/11/16.
//  Copyright © 2016 Isay González Lázaro. All rights reserved.
//

import UIKit
protocol DetailView {
    func startLoadingView()
    func reloadData()
    func finishLoadingView()
    func showError(error: NSError)
    func receiveFilmData(film:DetailFilm)
}
class DetailPresenter: NSObject {
    private let detailService:DetailService //class to manage requests
    private var detailView : DetailView? //Delegate for DetailPresenter
    var isRequestActive: Bool! // to know if i have an active request (false -> no request active, true->request active)
    
    //##########################################
    //init
    //detailService -> var to control services management
    //##########################################
    init(detailService:DetailService){
        
        self.detailService = detailService //set service manager
        self.isRequestActive=false //no request active at the beginnig
    }
    
    //##########################################
    //Set the delegate
    //delegate -> DetailView Delegate
    //##########################################
    func attachView(delegate:UIViewController){
        detailView = delegate as? DetailView //set the delegate
    }
    
    
    //##########################################
    //Call to service for a Detail
    //delegate -> DetailView Delegate
    //##########################################
    func obtainFilmDetail(ident:Int)
    {
        self.isRequestActive=true
        detailService.obtainFilmDetail(id:ident,{ response in
            //Do things done
            self.isRequestActive=false
            self.detailView?.finishLoadingView() // remove loading view
            
            if response is NSDictionary //check if response is correct
            {
                //do nothing
            }else
            {
                self.detailView?.showError(error: NSError(domain: "error", code: -1, userInfo: nil)) //throw error to the user
                return
            }
            
            let movie=DetailFilm.init(dictionary: response as! NSDictionary) //parse result data
            if let mov = movie // check if results is correct
            {
                self.detailView?.receiveFilmData(film: mov)
            }else
            {
                self.detailView?.showError(error: NSError(domain: "error", code: -1, userInfo: nil)) //throw error to the user
                return
            }
            
            
            
            
            },
                                       fail: { error in
                                        self.detailView?.finishLoadingView() // remove loading view
                                        //do things fail
                                        self.isRequestActive=false
                                        print (error)
                                        self.detailView?.showError(error: NSError(domain: "error", code: -1, userInfo: nil)) //throw error to the user
                                        
                                        
                                        
                                        
        })
    }
    
    //##########################################
    //Cancel request if i'm going to dissapear
    //##########################################
    
    func viewIsGoingToDissapear()
    {
        if (self.isRequestActive == true)
        {
            detailService.cancelRequest()
        }
    }
    
    
}
