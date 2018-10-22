//
//  APICall.swift
//  scan and go
//
//  Created by Samuel on 03-05-18.
//  Copyright © 2018 Samuel Garcia. All rights reserved.
//

import UIKit
import Alamofire
import CodableAlamofire

open class APICall {
    
    public func requestData(endpointName: String, method: HTTPMethod, params: [String : Any]? = nil, general: Int = 1, callback: @escaping (Data) -> Void) {
        let endpointData = getEndpoint(fromName: endpointName)
        let headers = ["Content-Type" : "application/json", "api_key" : endpointData.1
        , "language" : "en-US"]
        
        //esto esta porque tiempo, por alguna razon no recibe los parametros en el hearde como deberia para que fuera transparente.
        var urlhttp = ""
        if(endpointName == "popular"){
             urlhttp = endpointData.0 + "?api_key="+endpointData.1
        }else{
             urlhttp = endpointData.0 + general.description + "?api_key="+endpointData.1
        }
        
       
            Alamofire.request(urlhttp, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        return
                    }
                    callback(data)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    callback(Data())
                    
                }
            }

        
    }
    
    
    public func requestJSON(endpointName: String, method: HTTPMethod, params: [String : Any]? = nil, callback: @escaping (DataResponse<Any>) -> Void) {
        let endpointData = getEndpoint(fromName: endpointName)
        let headers = ["Content-Type" : "application/json", "x-api-key" : endpointData.1]
        Alamofire.request(endpointData.0, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response: DataResponse<Any>) in
                callback(response)
        }
    }
    
    public func requestString(endpointName: String, method: HTTPMethod, params: [String : Any]? = nil, callback: @escaping (DataResponse<String>) -> Void) {
        let endpointData = getEndpoint(fromName: endpointName)
        let headers = ["Content-Type" : "application/json", "x-api-key" : endpointData.1]
        let request = Alamofire.request(endpointData.0, method: method, parameters: params, encoding: /*JSONEncoding.default*/URLEncoding.default, headers: headers)
            .responseString { (response) in
                //print(response.request?.httpBody)
                callback(response)
        }
        print("Request Body: \(request.request?.httpBody)")
    }
    
    
    
    
    public func getEndpoint(fromName: String) -> (String, String) {
        guard let path = Bundle.main.path(forResource: "endpoints", ofType: "plist") else {
            debugPrint("ERROR: No se encontró archivo endpoints.plist")
            return ("", "")
        }
        let myDict = NSDictionary(contentsOfFile: path) as! [String : Any]
        guard let endpoint = myDict[fromName] as? [String : String] else {
            debugPrint("ERROR: No existe endpoint con el nombre \(fromName)")
            return ("", "")
        }
        return (endpoint["url"]!, endpoint["api-key"]!)
    }
    
    
}
