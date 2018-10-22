//
//  favoritesClass.swift
//  MiguelRequena
//
//  Created by Consultor on 21-10-18.
//  Copyright © 2018 marequena. All rights reserved.
//

import Foundation
enum favoritesClass {
    public static var listFavorites = [Int()]
    
    public static func isFavorite(id : Int) -> Bool {
        listFavorites = UserDefaults.standard.object(forKey: "FAVORITES") as! [Int]
        for favo in listFavorites {
            if favo == 0 {
                if let index = listFavorites.index(of:0) {
                    listFavorites.remove(at: index)}
            }
            if id == favo{
                return true
            }
        }
        return false
    }
    
    public static func markFavorite(id : Int) -> Bool {
        for favo in listFavorites {
            if favo == 0 {
                if let index = listFavorites.index(of:0) {
                    listFavorites.remove(at: index)}
            }

            if id == favo{
                if let index = listFavorites.index(of:id) {
                    listFavorites.remove(at: index)
                    return false
                }
                return false
            }
        }
            listFavorites.append(id)
            UserDefaults.standard.set(listFavorites, forKey: "FAVORITES")
        return true
    }
    
    
    
    
}
