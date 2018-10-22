//
//  MovieModel.swift
//  MiguelRequena
//
//  Created by Consultor on 21-10-18.
//  Copyright © 2018 marequena. All rights reserved.
//

struct FavoriteModel: Codable {
    
    
    var vote_count : Int
    var id : Int
    var video : Bool
    var vote_average : Double
    var title : String
    var popularity : Double
    var poster_path : String
    var original_language : String
    var original_title : String
    var genres: [genre]
    var backdrop_path : String
    var adult : Bool
    var overview : String
    var release_date : String
    
   
    init(){
         vote_count = Int()
         id = Int()
         video = true
         vote_average = Double()
         title = String()
         popularity = Double()
         poster_path = String()
         original_language = String()
         original_title = String()
         genres = [genre()]
         backdrop_path = String()
         adult = true
         overview = String()
         release_date = String()
    }
    
    private enum CodingKeys: String, CodingKey {
        case vote_count
        case id
        case video
        case vote_average
        case title
        case popularity
        case poster_path
        case original_language
        case original_title
        case genres
        case backdrop_path
        case adult
        case overview
        case release_date
    }
}

struct genre: Codable {
    
    

    var id : Int
    var name : String
    
    
    
    init(){
        id = Int()
        name = String()
    
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        
    }
}
