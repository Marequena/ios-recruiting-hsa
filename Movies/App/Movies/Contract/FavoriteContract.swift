//
//  FavoriteContract.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//
import UIKit

protocol FavoriteContract: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setFavoriteMovies(movies:[Movie])
    func setEmptyMovies()
    func setDeleteMovieFavorite()
}

