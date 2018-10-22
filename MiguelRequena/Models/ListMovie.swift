//
//  ListMovie.swift
//  MiguelRequena
//
//  Created by Consultor on 21-10-18.
//  Copyright © 2018 marequena. All rights reserved.
//

import Foundation

struct ListMovie:  Codable {
    let page : Int
    let total_results : Int
    let total_pages : Int
    let results : [MovieModel]?
        
        
        init(){
            page = 0
            total_pages = 0
            total_results = 0
            results = []
        }
        
        private enum CondingKeys: String, CodingKey {
            case page
            case total_pages
            case total_results
            case results
        }
}
