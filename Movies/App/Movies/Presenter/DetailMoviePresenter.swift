//
//  DetailMoviePresenter.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation
import RealmSwift
class DetailMoviePresenter {
    weak private var DetailMovieContract : DetailMovieContract?
    
    func attachView(view:DetailMovieContract){
        DetailMovieContract = view
    }
    
    func detachView() {
        DetailMovieContract = nil
    }
    
    func getGenres(genres:List<Int>){
        self.DetailMovieContract?.startLoading()
        var genresArray = [String]()
        for idGenre in genres{
            let genreObject = RealmService.shared.realm.object(ofType: Genre.self, forPrimaryKey: idGenre)
            if(genreObject != nil){
                genresArray.append((genreObject?.name)!)
            }
        }
        if genresArray.count == 0 {
            self.DetailMovieContract?.setEmptyGenres()
            self.DetailMovieContract?.finishLoading()
        }else{
            self.DetailMovieContract?.setGenres(genres: genresArray)
            self.DetailMovieContract?.finishLoading()
        }
       
        
    }
 
    
}

