//
//  RealmService.swift
//  Movies
//
//  Created by Dani Riders on 3/09/18.
//  Copyright © 2018 test. All rights reserved.
//


import Foundation
import RealmSwift
import UIKit

class RealmService{
    
    //enforce singleton
    private init(){}
    
    static let shared = RealmService()
    
    // deafault realm is a file in app documents directory
    var realm = try! Realm()
    
    static let realmErrorNotificationName = NSNotification.Name("RealError")
    
    // generic function to add an object to a realm
    /// - Parameter object: a generic type that subclasses Real class Object
    
    func add<T:Object>(_ object: T){
        do{
            try realm.write(){
                realm.add(object)
            }
        }catch{
            post(error)
        }
    }
    
    
    func update<T:Object>(_ object: T, with dictionary:[String:Any?]){
        
        do{
            try realm.write(){
                for(key,value) in dictionary{
                    
                    object.setValue(value, forKey: key)
                    
                }
            }
        }catch{
            post(error)
        }
    }
    
    func delete<T:Object>(_ object:T){
        do{
            try realm.write(){
                realm.delete(object)
            }
        }catch{
            post(error)
        }
    }
    
    
    func post(_ error:Error){
        // post on main queue to avoid potential crash in observers like wiev controllers.
        // Can specify queue in addObserver or in post either one should suffice.
        // Do it both places for "Belt and suspenders" goof proofing.
        DispatchQueue.main.async{
            NotificationCenter.default.post(name: RealmService.realmErrorNotificationName, object: error)
        }
    }
    
    func addObserverRealmError(in vc: UIViewController, completion: @escaping(Error?)->Void){
        let _ = NotificationCenter.default.addObserver(forName: RealmService.realmErrorNotificationName, object: nil, queue: OperationQueue.main){(notification) in completion(notification.object as? Error)}
    }
    
    func removeObserveRealmError(in vc: UIViewController){
        // last argument is a completion block
        // tutorial doesn't specify an observer, so all observers will be removed?
        NotificationCenter.default.removeObserver(vc, name: RealmService.realmErrorNotificationName, object: nil)
    }
}
