 //
 //  FilmsPresenter.swift
 //  TMDBPriv
 //
 //  Created by Isay González Lázaro on 27/11/16.
 //  Copyright © 2016 Isay González Lázaro. All rights reserved.
 //
 
 import UIKit
 
 
 protocol FilmsView {
    func startLoadingView()
    func reloadData()
    func finishLoadingView()
    func setFilms(films: NSMutableArray)
    func setEmptyFilms()
    func newSearchActions()
    func showMoreDataLoading()
    func hideMoreDataLoading()
    func showError(error: NSError)
    func updateResultsLabel(text: String)
    
 }
 class FilmsPresenter: NSObject {
    private let filmsService:FilmsService
    private var filmsView : FilmsView?
    
    var loadMore:Bool! //Flag to know if our request is to load more data (true -> is for more data, false->no)
    var movie:Results!
    var totalPages:Int! //total pages returned from a request
    var currentPage:Int!
    var isSearching:Bool!//to control if we are searching for an specific film (false -> we are not searching for a film. true-> we are searching for a film)
    var searchString:String!
    var moviesList: NSMutableArray!
    var requestIsActive:Bool! // to know if i have an active request (false -> no request active, true->request active)
    
    
    //##########################################
    //init
    //##########################################
    init(filmsService:FilmsService){
        self.totalPages=0 //set initialy to 0 (no request yet)
        self.filmsService = filmsService
        self.currentPage=0 // set initialy to 0 (no request yet)
        moviesList=[]//movie container is set to []
        isSearching=false; //we are not searching at the beginnig
        self.searchString="" //our search string should be empty at the beginnig
        self.requestIsActive=false //we haven't active request at the beginning
        self.loadMore=false //we don't need to load more data at the beginning
        
    }
    //##########################################
    //set the delegate
    //##########################################
    func attachView(delegate:UIViewController){
        filmsView = delegate as? FilmsView
    }
    
    //##########################################
    //call to service for a search
    //##########################################
    func makeSearchFilmsRequest (searchText:String)
    {
        filmsService.searchFilm(page:self.currentPage,query:searchText,{ response in
            //Do things done
            self.filmsView?.updateResultsLabel(text: "Resultados para: \"\(searchText)\"")
            if response is NSDictionary //check if response is correct
            {
                //do nothing
            }else
            {
                self.filmsView?.finishLoadingView() // remove loading view
                self.requestIsActive=false
                self.resetData()
                self.filmsView?.showError(error: NSError(domain: "error", code: -1, userInfo: nil)) //throw error to the user
                return
            }
            
            let movies=FilmsCollection.init(dictionary: response as! NSDictionary)! //parse result data
            if let mov = movies.results // check if results is correct
            {
                if(self.currentPage==1)
                {
                    self.moviesList.removeAllObjects()
                }
                self.moviesList.addObjects(from: mov) //add result data to container
                self.filmsView?.setEmptyFilms()
                self.filmsView?.setFilms(films: self.moviesList) //send container to view
                self.totalPages=movies.total_pages
                self.filmsView?.finishLoadingView() // remove loading view
                self.filmsView?.hideMoreDataLoading()
                self.requestIsActive=false
            }else
            {
                self.filmsView?.finishLoadingView() // remove loading view
                self.resetData()
                self.filmsView?.showError(error: NSError(domain: "error", code: -1, userInfo: nil)) //throw error to the user
                self.requestIsActive=false
                return
            }
            
            },
                                fail: { error in
                                    
                                    self.filmsView?.updateResultsLabel(text: "Resultados para: \"\(searchText)\"")
                                    //do things fail
                                    if (error?.code == -999)
                                    {
                                        //code -999 is a request cancel so we only should return our current result and subtrack 1 to currentPage
                                        if(self.currentPage>0)
                                        {
                                            self.currentPage=self.currentPage-1
                                            self.filmsView?.setFilms(films: self.moviesList) //send container to view
                                        }
                                    }else
                                    {
                                        self.requestIsActive=false
                                        self.filmsView?.finishLoadingView() // remove loading view
                                        self.resetData()
                                        self.filmsView?.showError(error: error!)
                                    }
                                    
                                    print (error)
        })
    }
    
    
    
    //
    
    
    //##########################################
    //call to service for popular films
    //##########################################
    
    func makePopularFilmsRequest()
    {
        filmsService.loadPopular(page:self.currentPage,{ response in
            //Do things done
            self.filmsView?.updateResultsLabel(text: "Películas más populares")
            
            if response is NSDictionary //check if response is correct
            {
                //do nothing
            }else
            {
                self.filmsView?.finishLoadingView() // remove loading view
                self.filmsView?.showError(error: NSError(domain: "error", code: -1, userInfo: nil)) //throw error to the user
                self.requestIsActive=false
                return
            }
            
            let movies=FilmsCollection.init(dictionary: response as! NSDictionary)! //parse result data
            if let mov = movies.results // check if results is correct
            {
                if(self.currentPage==1)
                {
                    self.moviesList.removeAllObjects()
                }
                self.moviesList.addObjects(from: mov) //add result data to container
                self.filmsView?.setEmptyFilms() // clear viewController films container
                self.filmsView?.setFilms(films: self.moviesList) //send container to view
                self.totalPages=movies.total_pages //save total pages
                self.filmsView?.finishLoadingView() // remove loading view
                self.filmsView?.hideMoreDataLoading()
                self.requestIsActive=false
            }else
            {
                self.filmsView?.finishLoadingView() // remove loading view
                self.resetData()
                self.filmsView?.showError(error: NSError(domain: "error", code: -1, userInfo: nil)) //throw error to the user
                self.requestIsActive=false
                return
            }
            
            
            },
                                 fail: { error in
                                    //do things fail
                                    print (error)
                                    self.filmsView?.finishLoadingView()
                                    self.filmsView?.updateResultsLabel(text: "Películas más populares")
                                    if (error?.code == -999)
                                    {
                                        //code -999 is a request cancel so we only should return our current result and subtrack 1 to currentPage
                                        self.filmsView?.setFilms(films: self.moviesList) //send container to view
                                        if (self.currentPage>0)
                                        {
                                            self.currentPage = self.currentPage-1
                                        }
                                        
                                    }else
                                    {
                                        self.requestIsActive=false
                                        self.resetData()
                                        self.filmsView?.showError(error: error!)
                                    }
        })
        
    }
    
    //##########################################
    //manage current status to decide what to do to call the popular films service
    //##########################################
    func getPopularfilms()
    {
        if (self.isSearching==true)
        {
            if (self.requestIsActive==true)
            {
                self.cancelRequest()
            }
            self.resetData()
            self.isSearching=false
        }
        
        if (self.totalPages != 0 && self.currentPage==self.totalPages)
        {
            self.loadMore=false
            self.filmsView?.finishLoadingView()
            
            return
        }
        
        self.currentPage = self.currentPage + 1
        self.requestIsActive=true
        if(self.loadMore==true)
        {
            self.filmsView?.showMoreDataLoading()
        }else
        {
            self.filmsView?.startLoadingView()
        }
        self.makePopularFilmsRequest()
        
    }
    
    
    //##########################################
    //manage current status to decide what to do to call the search films service
    //##########################################
    func searchFilms(searchText: String)
    {
        if (searchText == "")
        {
            
            self.searchString=searchText
            self.isSearching=true
            self.getPopularfilms()
            return
        }
        
        
        if (self.isSearching==false)
        {
            if (self.requestIsActive==true)
            {
                self.cancelRequest()
            }
            self.resetData()
        }
        
        
        
        
        if (searchText != self.searchString)
        {
            
            self.resetData()
        }
        self.isSearching=true
        self.searchString=searchText
        
        
        
        if (self.totalPages != 0 && self.currentPage==self.totalPages)
        {
            self.loadMore=false
            self.filmsView?.finishLoadingView()
            return
        }
        self.currentPage = self.currentPage + 1
        
        
        if(self.loadMore==true)
        {
            self.filmsView?.showMoreDataLoading()
        }else
        {
            self.filmsView?.startLoadingView()
        }
        
        self.requestIsActive=true
        self.makeSearchFilmsRequest(searchText:searchText)
    }
    
    
    
    //##########################################
    //manage current status to decide if should call to popular films service or search service
    //##########################################
    func loadMoreData()
    {
        if (self.requestIsActive == true)
        {
            return
        }
        self.loadMore=true
        
        if (self.searchString == "")
        {
            self.getPopularfilms()
        }else
        {
            
            self.searchFilms(searchText: self.searchString)
        }
        
    }
    //##########################################
    //clear all data
    //##########################################
    func resetData()
    {
        self.isSearching=false
        self.searchString=""
        self.loadMore=false
        self.currentPage=0
        self.totalPages=0
        self.filmsView?.setEmptyFilms()
        self.moviesList.removeAllObjects()
    }
    
    //##########################################
    //cancel current request
    //##########################################
    func cancelRequest()
    {
        filmsService.cancelRequest() // cancel current request
    }
    
    //##########################################
    //a film has been pressed
    //##########################################
    func segueWillBeExecuted()
    {
        filmsService.cancelRequest() // cancel current request
    }
    
 }
