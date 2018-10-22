//
//  MovieService.swift
//  MiguelRequena
//
//  Created by Consultor on 21-10-18.
//  Copyright © 2018 marequena. All rights reserved.
//

import Foundation
import Alamofire

class MovieService {
    
    let services = APICall()
    
   
    func getMovie(page: Int,  completionHandler: @escaping (ListMovie?, String?) -> Void){
        let parameters = ["page" : page.description]
        services.requestData(endpointName: "popular", method: .get, params : parameters) { response in
            do {
                let responseData = String(data: response, encoding: String.Encoding.utf8)
                let decoder = JSONDecoder()
                let data = try decoder.decode(ListMovie.self, from: response)
                completionHandler(data, "Success")
            } catch {
                print("error: \(error.localizedDescription)")
                let cResponseM = ListMovie()
                completionHandler(cResponseM, "Error al traer la data")
            }
        }
    }
    
    func getMovieDet(idMovie: Int,  completionHandler: @escaping (FavoriteModel?, String?) -> Void){
        let parameters = ["movie_id" : idMovie.description]
        services.requestData(endpointName: "getmovie", method: .get, params : nil, general : idMovie) { response in
            do {
                let responseData = String(data: response, encoding: String.Encoding.utf8)
                let decoder = JSONDecoder()
                let data = try decoder.decode(FavoriteModel.self, from: response)
                completionHandler(data, "Success")
            } catch {
                print("error: \(error.localizedDescription)")
                let cResponseM = FavoriteModel()
                completionHandler(cResponseM, "Error al traer la data")
            }
        }
    }
   
}
