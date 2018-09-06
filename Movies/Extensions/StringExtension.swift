//
//  StringExtension.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

//MARK: Extension String
extension String{
    
    /**
     Funcion utilizada para obtener primera letra de string
     */
    func firstLetter()->String{
        return String(self.first!)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    /**
     Funcion utilizada para poner en mayuscula primera letra de string
     */
    //    func capitalizingFirstLetter() -> String {
    //        let first = String(characters.prefix(1)).capitalized
    //        let other = String(characters.dropFirst()).lowercased()
    //        return first + other
    //    }
    
    
    //    mutating func capitalizeFirstLetter() {
    //        self = self.capitalizingFirstLetter()
    //    }
    
    /**
     Funcion utilizada para convertir string base 64 a string
     */
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    /**
     Funcion utilizada para convertir string a base 64
     */
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    /**
     Funcion utilizada para limpiar espacios de string
     */
    func clearSpacesString () -> String{
        return self.trimmingCharacters(in: .whitespaces)
    }
    
}
