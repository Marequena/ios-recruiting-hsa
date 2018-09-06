//
//  Utils.swift
//  EnrollmentKit
//
//  Created by Dennise Mendez on 6/20/18.
//  Copyright © 2018 NovopaymUtient. All rights reserved.
//

import Foundation
import UIKit

class Utils{
    
    static func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    static func downloadImage(Url:String,onCompletion:@escaping(Data)->Void){
        let url = URL(string: Url)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                onCompletion(data!)
            }
        }
        
    }
    
}
