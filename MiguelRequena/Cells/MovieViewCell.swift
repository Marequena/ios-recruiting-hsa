//
//  userListTableViewCell.swift
//  ekattor_ios
//
//  Created by Creativeitem on 7/30/15.
//  Copyright (c) 2015 Creativeitem. All rights reserved.
//

import UIKit


class MovieViewCell: UICollectionViewCell {
    
    var delegate : MoviesViewController?
    
    @IBOutlet var imageMovie: UIImageView!
    
    @IBOutlet var titleMovie: UILabel!
    
    @IBOutlet var favoriteButton: UIButton!
    
    @IBOutlet var vista: UIView!
    
    var movie = MovieModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    public func configure(movie : MovieModel) {
        self.movie = movie
        titleMovie.text = movie.original_title
        let url = URL(string: "https://image.tmdb.org/t/p/original" + movie.poster_path ?? "")
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        imageMovie.image = UIImage(data: data!)
        
        if favoritesClass.isFavorite(id: movie.id){
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
        
    }

    func showShadow() {

        self.layoutIfNeeded()
    }
    
    
    @IBAction func markFavorite(_ sender: UIButton) {
        
        if favoritesClass.markFavorite(id: self.movie.id) {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
    }
    
  
    
}

