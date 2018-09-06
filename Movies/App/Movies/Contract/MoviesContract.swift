
//
//  MoviesContract.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

protocol MoviesContract: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setMovies(movies:[Movie])
    func setEmptyMovies()
}
