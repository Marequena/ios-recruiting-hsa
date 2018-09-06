//
//  APIClient.swift
//  EnrollmentKit
//
//  Created by Dennise Mendez on 6/11/18.
//  Copyright © 2018 Novopayment. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    
    static func getGenres(onCompletion:@escaping([Genre])->Void,onError:@escaping(Error)->Void){
        
        let url = "\(Server.baseURL)\(Services.genreList)?api_key=\(Api.apiKey)&language=\(Api.language)"
        
        let codingUrlService = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(codingUrlService!).responseJSON(completionHandler: {response in
            
            switch response.result{
            case .success:
                
                if let jsonResponse = response.result.value {
                    let json = jsonResponse as? [String: Any]
                    let jsonDataString:String = Utils.json(from: json!["genres"] as Any)!
                    if let jsonData = jsonDataString.data(using: .utf8)
                    {
                        do{
                            let response = try JSONDecoder().decode([Genre].self, from: jsonData)
                            for index in response{
                                RealmService.shared.add(index)
                            }
                            UserDefaults.standard.set(true, forKey: "genres")
                            onCompletion(response)
                            
                        }catch{
                            onError(error)
                        }
                    }
                }
                break
            case .failure(let error):
                onError(error)
            }
        })
        
    }
    
    static func getMovies(page:Int,onCompletion:@escaping([Movie])->Void,onError:@escaping(Error)->Void){
        
        let url = "\(Server.baseURL)\(Services.popularMovies)?api_key=\(Api.apiKey)&language=\(Api.language)&page=\(String(page))"
        
        let codingUrlService = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(codingUrlService!).responseJSON(completionHandler: {response in
            
            switch response.result{
            case .success:
                
                if let jsonResponse = response.result.value {
                    let json = jsonResponse as? [String: Any]
                    let jsonDataString:String = Utils.json(from: json!["results"] as Any)!
                    if let jsonData = jsonDataString.data(using: .utf8)
                    {
                        do{
                            let response = try JSONDecoder().decode([Movie].self, from: jsonData)
                            print("response",response)
                            onCompletion(response)
                            
                        }catch{
                            onError(error)
                        }
                    }
                }
                break
            case .failure(let error):
                onError(error)
            }
        })
        
    }
    
    
}
extension DataRequest {
    public func LogRequest() -> Self {
        debugPrint(self)
        return self
    }
}
