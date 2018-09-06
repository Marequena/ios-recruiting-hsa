//
//  Movie.swift
//  Movies
//
//  Created by Dani Riders on 3/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class Movie:Object, Decodable {
    
    enum Property:String{
        case id, title ,posterpath,genreids,overview,releasedate
    }
    
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var posterpath = ""
    var genreids = List<Int>()
    @objc dynamic var overview = ""
    @objc dynamic var releasedate = ""
    @objc dynamic var isFavorite = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    private enum PersonCodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterpath = "poster_path"
        case genreids = "genre_ids"
        case overview = "overview"
        case releasedate = "release_date"
    }
    
    convenience init(id:Int,title:String,posterpath:String,genreids:List<Int>,overview:String,releasedate:String,isFavorite:Bool){
        
        self.init()
        self.id = id
        self.title = title
        self.posterpath = posterpath
        self.genreids = genreids
        self.overview = overview
        self.releasedate = releasedate
        self.isFavorite = isFavorite
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        let MovieValues = try decoder.container(keyedBy: PersonCodingKeys.self)
        
        let id = (try MovieValues.decodeIfPresent(Int.self, forKey: .id))!
        let title = (try MovieValues.decodeIfPresent(String.self, forKey: .title))!
        let posterpath = (try MovieValues.decodeIfPresent(String.self, forKey: .posterpath))!
        
        let genreArray = try MovieValues.decode([Int].self, forKey: .genreids)
        let genreList = List<Int>()
        genreList.append(objectsIn: genreArray)
        
        let overview = (try MovieValues.decodeIfPresent(String.self, forKey: .overview))!
        let releasedate = (try MovieValues.decodeIfPresent(String.self, forKey: .releasedate))!
        
        self.init(id:id,title:title,posterpath:posterpath,genreids:genreList,overview:overview,releasedate:releasedate,isFavorite:false)
        
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
