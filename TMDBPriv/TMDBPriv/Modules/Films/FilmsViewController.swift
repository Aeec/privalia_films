//
//  FilmsViewController.swift
//  TMDBPriv
//
//  Created by Isay González Lázaro on 24/11/16.
//  Copyright © 2016 Isay González Lázaro. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import Foundation


class FilmsViewController: UIViewController {
    
    
    
    @IBOutlet weak var noResultsImageView: UIImageView! //image to be shown when we haven't results
    @IBOutlet weak var resultsLabel: UILabel! //label to show what is happening
    @IBOutlet weak var errorView: UIView! //error view to be shown if something has gone wrong
    @IBOutlet weak var loadingView: UIView! // loading view to be shown during a search
    @IBOutlet weak var searchBar: UISearchBar! //SearchBar to search for an specific film
    @IBOutlet weak var filmsTableView: UITableView!// Table to show films as result
    var moviesList: NSMutableArray!//MutableArray of films to show on filmsTableView
    var isSearching:Bool!//to control if we are searching for an specific film (false -> we are not searching for a film. true-> we are searching for a film)
    var isLoadingCell:Bool!//flag to know if loading cell to load more data is shown (false-> not should shown true->should shown)
    let filmsPresenter = FilmsPresenter(filmsService: FilmsService()) // View's presenter to manage view events
  
    var tap: UITapGestureRecognizer! //to control gesture recognizer to hide keyboard
    
    
    
    //##########################################
    //viewDidLoad
    //##########################################
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isLoadingCell=false
        self.isSearching=false
        self.moviesList=[]
        self.filmsPresenter.attachView(delegate:self)
        self.filmsPresenter.getPopularfilms()
        
        self.tap = UITapGestureRecognizer(target: self, action: #selector(FilmsViewController.dismissKeyboard))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //##########################################
    //set the place holder and hidde navigation bar
    //##########################################
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.placeholder="Buscar película"
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    //##########################################
    //Calls this function when the tap is recognized.
    //##########################################
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.searchBar.resignFirstResponder()
        self.view.removeGestureRecognizer(tap)
    }
    
    
    
    //##########################################
    //button from error view action
    //##########################################
    
    @IBAction func retryButton(_ sender: AnyObject) {
        self.errorView.isHidden=true
        self.filmsPresenter.resetData()
        self.filmsPresenter.getPopularfilms()
    }
    
    
    
    //##########################################
    //didReceiveMemoryWarning
    //##########################################
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showDetail" {
            self.filmsPresenter.segueWillBeExecuted()
            if let indexPath = self.filmsTableView.indexPathForSelectedRow {
                let selectedFilm = self.moviesList![indexPath.row] as! Results
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.film = selectedFilm
            }
        }
    }
}
extension FilmsViewController : UITableViewDataSource {
    
    //##########################################
    //row height different if should show loading cell or film cell
    //##########################################
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == moviesList.count-1 && self.isLoadingCell == true)
        {
            return 40.0
        }else
        {
            return 300.0
        }
    }
    
    //##########################################
    //1 section
    //##########################################
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //##########################################
    //comes from the films container movieList
    //##########################################
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    //##########################################
    //configure the cell based on the film information, also configure load more cell
    //##########################################
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*if(self.controlReload == true)
         {
         if (indexPath.row==self.moviesList.count-1)
         {
         
         }
         }*/
        if (indexPath.row == moviesList.count-1 && self.isLoadingCell == true)
        {
            let cellID = "LoadingCell"
            
            let cell = self.filmsTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
            return cell
        }
        
        
        let cellID = "FilmCell"
        //let cellID = "\(indexPath.row)"
        
        let cell = self.filmsTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FilmCell
        let film: Results = self.moviesList[indexPath.row] as! Results
        if let title = film.title
        {
            cell.nameLabel.text = title
        }else
        {
            cell.nameLabel.text = "NO TITLE"
        }
        if let yr = film.release_date
        {
            var year = yr.components(separatedBy: "-")
            
            if (year.count > 0)
            {
                cell.year.text=year[0]
            }
            
        }else
        {
            cell.year.text = ""
        }
        if let overview = film.overview
        {
            cell.overView.text=overview
        }else
        {
            cell.overView.text=""
        }
        
        if let popularity = film.popularity
        {
            cell.pupularidad.text="\(Double(round(100*popularity)/100))"
        }else
        {
            cell.pupularidad.text=""
        }
        
        if let voteAvergage = film.vote_average
        {
            cell.votes.text="\(Double(round(100*voteAvergage)/100))"
            
        }else
        {
            cell.votes.text=""
        }
        
        cell.recipeImageView?.image = UIImage(named: "imagen_generica.png")
        if let poster = film.poster_path
        {
            //load image
            let url=URL(string:"https://image.tmdb.org/t/p/w185/\(poster)")
            cell.recipeImageView?.af_setImage(withURL: url!,
                                              placeholderImage: nil,
                                              filter: nil,
                                              imageTransition: .crossDissolve(0.2))
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    
}
extension FilmsViewController : UITableViewDelegate {
    
    //##########################################
    //disable searchbar interaction during scrolling
    //##########################################
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.isUserInteractionEnabled=false
        self.searchBar.resignFirstResponder()
    }
    
    //##########################################
    //enable searchbar interaction when scroll is stoped
    //##########################################
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.searchBar.isUserInteractionEnabled=true
    }
    
    //##########################################
    //control if we have arrived to the last cell to load more
    //##########################################
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            print(" end of the table")
            
            if(self.moviesList.count>0)
            {
                self.filmsPresenter.loadMoreData()
            }
            
            
        }
    }
}



extension FilmsViewController: UISearchBarDelegate
{
    //##########################################
    //remove keyboard
    //##########################################
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //
        self.searchBar.resignFirstResponder()
        self.view.removeGestureRecognizer(tap)
    }
    
    //##########################################
    //enable tap gesture recognizer to remove keyboard touching a clear area
    //##########################################
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //keyboard will be shown
        
        self.view.addGestureRecognizer(tap)
    }
    
    //##########################################
    //send a signal for each character pressed to load data
    //##########################################
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filmsPresenter.searchFilms(searchText: searchText)
        self.moviesList.removeAllObjects()
        self.showNoResults() //
        self.filmsTableView.reloadData()
        self.filmsTableView.setContentOffset(CGPoint.zero, animated: true)
        
        
    }
    
    //##########################################
    //show or hidde no results image if datasource is empty
    //##########################################
    func showNoResults()
    {
        if (self.moviesList.count == 0)
        {
            self.noResultsImageView.isHidden=false
        }else
        {
            self.noResultsImageView.isHidden=true
        }
    }
    
    
}
extension FilmsViewController:FilmsView
{
    //##########################################
    //show loading view
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
    //hidde loading view
    //##########################################
    func finishLoadingView()
    {
        self.loadingView.isHidden=true
    }
    
    //##########################################
    //load films from service to datasource
    //##########################################
    func setFilms(films: NSMutableArray)
    {
        self.isLoadingCell=false //shouldn't show loading cell
        self.moviesList.addObjects(from: films as [AnyObject])
        self.showNoResults()
        self.filmsTableView.reloadData()
    }
    //##########################################
    //remove data source content
    //##########################################
    func setEmptyFilms()
    {
        self.moviesList .removeAllObjects()
    }
    //##########################################
    //newSearchActions
    //##########################################
    func newSearchActions()
    {
        
    }
    //##########################################
    //show loading cell for more results
    //##########################################
    func showMoreDataLoading()
    {
        self.isLoadingCell=true // should show loading cell
        let loading:String = "Loading"
        self.moviesList.add(loading) //add a new item to datasource to show a loading cell
        self.showNoResults()
        self.filmsTableView.reloadData()
    }
    //##########################################
    //change flag to hidde load more loading cell
    //##########################################
    func hideMoreDataLoading()
    {
        
        //self.moviesList.removeLastObject()//remove last item to datasource to remove the loading cell
        self.isLoadingCell=false //shouldn't show loading cell
        //self.filmsTableView.reloadData()
    }
    
    //##########################################
    //show error view
    //##########################################
    
    func showError(error: NSError)
    {
        self.moviesList.removeAllObjects()
        self.filmsTableView.reloadData()
        self.errorView.isHidden=false
        self.searchBar.resignFirstResponder()
        self.searchBar.text=""
    }
    
    //##########################################
    //change results label
    //##########################################
    func updateResultsLabel(text: String)
    {
        self.resultsLabel.text=text
    }
}

