
//
//  FavoriteViewController.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var navBar: NavigationView!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var FavoritesTblView: UITableView!
    @IBOutlet weak var BtnRemoveFilter: UIButton!
    @IBOutlet weak var HeightBtnRemoveLayoutConstraint: NSLayoutConstraint!
    private let refreshControl = UIRefreshControl()
    
    let presenter = FavoritePresenter()
    var moviesFavorites = [Movie]()
    var dataFilter = [Movie]()
    var filters = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.navTitle(title: "Movies")
        navBar.rightButtonFilter(state: true)
        navBar.rightCallBack = {state in
            self.ActionRight()
        }
        presenter.attachView(view: self)
        self.SetUpTable()
        presenter.getFavoriteMovies()
        HeightBtnRemoveLayoutConstraint.constant = 0
        BtnRemoveFilter.isHidden = true
        
        if #available(iOS 10.0, *) {
            FavoritesTblView.refreshControl = refreshControl
        } else {
            FavoritesTblView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(keyboardWillHide))
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        // Do any additional setup after loading the view.
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        self.presenter.getFavoriteMovies()
    }
    
    @objc func keyboardWillHide() {
        view.endEditing(true)
    }
    
    func ActionRight() {
        let filterView = FilterHelper.openFilter()
        filterView.selectedItemsCallBack={(itemsFilter)in
            self.filters = itemsFilter
            self.filterFavorite()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.present(filterView, animated: true, completion: nil)
        }
    }
    
    
    private func SetUpTable(){
        FavoritesTblView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        
    }
    @IBAction func TouchUpRemoveFilter(_ sender: Any) {
        dataFilter = moviesFavorites
        HeightBtnRemoveLayoutConstraint.constant = 0
        BtnRemoveFilter.isHidden = true
        FavoritesTblView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteViewController:FavoriteContract{
    func setDeleteMovieFavorite() {
        let alertController = UIAlertController(title: "Alert", message: "The movie has been removed", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // ... Do something
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        self.FavoritesTblView.reloadData()
    }
    
    func startLoading() {
        self.view.showBlurLoader()
    }
    
    func finishLoading() {
        self.view.removeBluerLoader()
    }
    
    func setFavoriteMovies(movies: [Movie]) {
        self.moviesFavorites = movies
        self.dataFilter = movies
        self.FavoritesTblView.reloadData()
    }
    
    func setEmptyMovies() {
        let alertController = UIAlertController(title: "Alert", message: "Has not added movies to favorites.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // ... Do something
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension FavoriteViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //Devolvemos el número de secciones
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 91.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.dataFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = dataFilter[indexPath.row]
        let cell = FavoritesTblView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
        
        Utils.downloadImage(Url: "\(Server.baseImg)\(movie.posterpath)") { (data) in
            cell.ImgViewMovie.image = UIImage(data: data)
            cell.LblName.text = movie.title
            cell.LblModel.text = movie.releasedate
            cell.TxtViewDescription.text = movie.overview
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let UnfavoriteAction = UITableViewRowAction(style: .default, title: "Unfavorite", handler:{action, indexpath in
            let movie = self.dataFilter[indexPath.row]
            self.presenter.deleteMovieFavorite(movie: movie)
        })
        return [UnfavoriteAction]
    }
    
}

extension FavoriteViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataFilter = moviesFavorites
        if searchText != "", searchText.count > 0 {
            dataFilter = dataFilter.filter{$0.title.lowercased().contains(searchText.lowercased())}
            
        }
        FavoritesTblView.reloadData()
    }
    
    func filterFavorite(){
        
        dataFilter = dataFilter.filter{$0.releasedate.contains(self.filters[0]["year"] as! String)&&$0.genreids.contains(self.filters[1]["id"] as! Int)}
        
        HeightBtnRemoveLayoutConstraint.constant = 40
        BtnRemoveFilter.isHidden = false
        
        
        FavoritesTblView.reloadData()
        
    }
}
