//
//  ViewController.swift
//  MiguelRequena
//
//  Created by Consultor on 21-10-18.
//  Copyright © 2018 marequena. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet var collectionMovies: UICollectionView!
    
    
    
    var ServiceMovie = MovieService()
    var listMovies = ListMovie()
    var arrayMovie = [MovieModel]()
    var page = 1
    
    var isLoading: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionMovies.delegate = self
        self.collectionMovies.dataSource = self
        self.collectionMovies.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieViewCell")
        page =  1
        loadMovies()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func loadMovies(){
            let sv = UIViewController.displaySpinner(onView: self.view)
        ServiceMovie.getMovie( page : self.page) { data, error in
            self.listMovies = data!
            for movi in self.listMovies.results! {
                self.arrayMovie.append(movi)
            }
            self.collectionMovies.reloadData()
            UIViewController.removeSpinner(spinner: sv)
        }
    }
    

    
}

extension MoviesViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.size.width/2)-5 , height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath as IndexPath) as! MovieViewCell
        cell.delegate = self
        cell.configure(movie: arrayMovie[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetMovie") as! DetMovieViewController
       destinationViewController.idMovie = arrayMovie[indexPath.row].id
        self.present(destinationViewController, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
   if indexPath.item == arrayMovie.count{
            self.page += 1
             self.loadMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
            
            return headerView
        }
        
        return UICollectionReusableView()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            //loadSomeDataAndIncreaseDataLengthFunction()
            self.page += 1
            self.loadMovies()
        }
    }
    
    
}


extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    
    
}
