//
//  FavoritePresenter.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class FavoritePresenter {
    weak private var FavoriteContract : FavoriteContract?
    
    func attachView(view:FavoriteContract){
        FavoriteContract = view
    }
    
    func detachView() {
        FavoriteContract = nil
    }
    
    func getFavoriteMovies(){
        self.FavoriteContract?.startLoading()
        
        let dataMovies = RealmService.shared.realm.objects(Movie.self)
        if(dataMovies.count == 0){
            self.FavoriteContract?.setEmptyMovies()
        }else{
            let arrayObject = Array(dataMovies)
            
            self.FavoriteContract?.setFavoriteMovies(movies: arrayObject)
        }
        
        self.FavoriteContract?.finishLoading()
    }
    func deleteMovieFavorite(movie:Movie){
        RealmService.shared.delete(movie)
        self.FavoriteContract?.setDeleteMovieFavorite()
    }
}
