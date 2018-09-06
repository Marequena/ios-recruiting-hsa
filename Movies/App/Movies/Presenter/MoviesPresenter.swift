//
//  MoviesPresenter.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

class MoviesPresenter {
    weak private var MoviesContract : MoviesContract?
    
    func attachView(view:MoviesContract){
        MoviesContract = view
    }
    
    func detachView() {
        MoviesContract = nil
    }
    
    func getMovies(){
        self.MoviesContract?.startLoading()
        APIClient.getMovies(page: 1, onCompletion: { (movies) in
            let genres = UserDefaults.standard.bool(forKey: "genres")
            if(!genres){
                APIClient.getGenres(onCompletion: { (genres) in
                    if(movies.count == 0){
                        self.MoviesContract?.setEmptyMovies()
                    }else{
                        self.MoviesContract?.setMovies(movies: movies)
                    }
                    
                }, onError: { (error) in
                    self.MoviesContract?.setEmptyMovies()
                    self.MoviesContract?.finishLoading()
                })
                
            }else{
                if(movies.count == 0){
                    self.MoviesContract?.setEmptyMovies()
                }else{
                    self.MoviesContract?.setMovies(movies: movies)
                }
            }
            
            self.MoviesContract?.finishLoading()
        }) { (error) in
            self.MoviesContract?.setEmptyMovies()
            self.MoviesContract?.finishLoading()
        }
        
    }
}
