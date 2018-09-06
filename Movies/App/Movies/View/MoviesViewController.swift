//
//  MoviesViewController.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var NavBar: NavigationView!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var infiniteCollectionView: UICollectionView!
   
    let presenter = MoviesPresenter()
    var movies = [Movie]()
    var dataFilter = [Movie]()
    lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavBar.navTitle(title: "Movies")
        presenter.attachView(view: self)
        registerCell()
        presenter.getMovies()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(keyboardWillHide))
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillHide() {
        view.endEditing(true)
    }
    
    
    private func registerCell() {
        infiniteCollectionView.register(UINib.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension MoviesViewController: MoviesContract{
    func setMovies(movies: [Movie]) {
        self.movies = movies
        self.dataFilter = movies
        self.infiniteCollectionView.reloadData()
    }
    
    func setEmptyMovies() {
        let alertController = UIAlertController(title: "Alert", message: "No movies were found.", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // ... Do something
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func startLoading() {
        self.view.showBlurLoader()
    }
    
    func finishLoading() {
        self.view.removeBluerLoader()
    }
    
}

extension MoviesViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataFilter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((self.infiniteCollectionView.frame.size.width - 20)/2)
        return CGSize(width: CGFloat(width), height: CGFloat(width+40))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.dataFilter[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.movieObject = movie
        
        Utils.downloadImage(Url: Server.baseImg+movie.posterpath) { (dataImage) in
            cell.ImgViewMovie.image = UIImage(data: dataImage)
            cell.LblName.text = movie.title
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let movie = self.dataFilter[indexPath.row]
        
        let DetailMovie = storyboard?.instantiateViewController(withIdentifier: DetailMovieViewController.identifier) as! DetailMovieViewController
        DetailMovie.movie = movie
        self.navigationController?.pushViewController(DetailMovie, animated: true)
        
    }
}

extension MoviesViewController : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension MoviesViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataFilter = movies
        
        if searchText != "", searchText.count > 0 {
           dataFilter = dataFilter.filter{$0.title.lowercased().contains(searchText.lowercased())}
          
        }
        infiniteCollectionView.reloadData()
    }
}

