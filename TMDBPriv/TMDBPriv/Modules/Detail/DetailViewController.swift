//
//  DetailViewController.swift
//  TMDBPriv
//
//  Created by Isay González Lázaro on 27/11/16.
//  Copyright © 2016 Isay González Lázaro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var homepage: UILabel! //Detail var
    @IBOutlet weak var imdb_id: UILabel!//Detail var
    @IBOutlet weak var titleF: UILabel!//Detail var
    @IBOutlet weak var original_language: UILabel!//Detail var
    @IBOutlet weak var original_title: UILabel!//Detail var
    @IBOutlet weak var popularity: UILabel!//Detail var
    @IBOutlet weak var poster_path: UIImageView!//Detail image
    @IBOutlet weak var runtime: UILabel!//Detail var
    @IBOutlet weak var vote_average: UILabel!//Detail var
    @IBOutlet weak var release_date: UILabel!//Detail var
    @IBOutlet weak var overview: UILabel!//Detail var
    @IBOutlet weak var loadingView: UIView! //loading view (should be shown when we are wating for response)
    let detailPresenter = DetailPresenter(detailService: DetailService()) // View's presenter to manage view events
    var movie:DetailFilm!
    var film: Results!
    
    //##########################################
    //viewDidLoad
    //##########################################
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView.isHidden=false //loading view should be hidden at the beginning
    }
    
    //##########################################
    //Send a message to alert presenter for dissapear
    //##########################################
    override func viewWillDisappear(_ animated: Bool) {
        self.detailPresenter.viewIsGoingToDissapear()
    }
    
    //##########################################
    //Configure delegate and send a request
    //##########################################
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.detailPresenter.attachView(delegate:self)
        self.detailPresenter.obtainFilmDetail(ident: film.id!)
    }
    
    //##########################################
    //remove navigation bar
    //##########################################
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //##########################################
    //Pop view controller to return back
    //##########################################
    func backToPreviousView()
    {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

    //##########################################
    //BackButton Action to return to previous viewController
    //##########################################
    @IBAction func backButtonClicked(_ sender: AnyObject) {
        self.backToPreviousView()
    }
    //##########################################
    //Error button action to return to previous viewController
    //##########################################
    @IBAction func errorButtonClicked(_ sender: AnyObject) {
        self.backToPreviousView()
    }

}
extension DetailViewController:DetailView
{
    //##########################################
    //loading view should be shown
    //##########################################
    func startLoadingView()
    {
        self.loadingView.isHidden=false
    }
    //##########################################
    //reloadData
    //##########################################
    func reloadData()
    {
        
    }
    //##########################################
    //loading view shold be hidden
    //##########################################
    func finishLoadingView()
    {
        self.loadingView.isHidden=true
}
    //##########################################
    //show error
    //##########################################
    func showError(error: NSError)
    {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.errorView.isHidden = false
    }
    
    //##########################################
    //detail information has been received
    //##########################################
    func receiveFilmData(film:DetailFilm)
    {
        self.movie=film
        
        if let yr = film.release_date
        {
            var year = yr.components(separatedBy: "-")
            if (year.count > 0)
            {
                self.release_date.text="Año: \(year[0])"
            }
        }else
        {
            self.release_date.text=""
        }
        
        if let popularity = film.popularity
        {
            self.popularity.text="Valoración: \(Double(round(100*popularity)/100))"
        }else
        {
            self.popularity.text=""
        }
       
        
        if let homepage = film.homepage
        {
          self.homepage.text = "Web: \(homepage)"
        }else
        {
          self.homepage.text = ""
        }
        if let imdbId = film.imdb_id
        {
           self.imdb_id.text="IMDB: \(imdbId)"
        }else
        {
          self.imdb_id.text="IMDB: -"
        }
        if let originalLanguage = film.original_language
        {
            self.original_language.text="Lengua original: \(originalLanguage)"
        }else
        {
            self.original_language.text="Lengua original: -"
        }
        if let originalTitle = film.original_title
        {
            self.original_title.text="Título original: \(originalTitle)"
        }else
        {
            self.original_title.text="Título original: -"
        }
        if let runtime = film.runtime
        {
            self.runtime.text="Duración: \(runtime)"
        }else
        {
            self.runtime.text="Duración: -"
        }
        if let overview = film.overview
        {
            self.overview.text="Sinopsis: \(overview)"
        }else
        {
            self.overview.text="Sinopsis: -"
        }
        if let titleF = film.title
        {
            self.titleF.text="\(titleF)"
        }else
        {
            self.titleF.text="NO TITLE"
        }

        if let poster = film.poster_path
        {
            //call for image
            let url=URL(string:"https://image.tmdb.org/t/p/w185/\(poster)")
            self.poster_path.af_setImage(withURL: url!,
                                              placeholderImage: UIImage(named:"pre.jpg"),
                                              filter: nil,
                                              imageTransition: .crossDissolve(0.2))
            
        }

    }
}




