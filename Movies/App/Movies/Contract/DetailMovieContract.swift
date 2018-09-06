//
//  DetailMovieContract.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

protocol DetailMovieContract: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setGenres(genres:[String])
    func setEmptyGenres()
}
