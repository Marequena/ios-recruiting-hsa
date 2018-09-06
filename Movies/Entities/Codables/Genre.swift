//
//  Contact.swift
//  Movies
//
//  Created by Dani Riders on 3/09/18.
//  Copyright © 2018 test. All rights reserved.
//
import UIKit
import RealmSwift
import Realm


class Genre :Object, Decodable {
    
    enum Property:String{
        case id, name
    }
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    private enum PersonCodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        
    }
    
    convenience init(id:Int,name:String){
        
        self.init()
        self.id = id
        self.name = name
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        let GenreValues = try decoder.container(keyedBy: PersonCodingKeys.self)
        
        let id = (try GenreValues.decodeIfPresent(Int.self, forKey: .id))!
        let name = (try GenreValues.decodeIfPresent(String.self, forKey: .name))!
        
        self.init(id:  id, name: name)
        
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
