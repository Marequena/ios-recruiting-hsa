//
//  AlertHelper.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//
import Foundation
import UIKit

struct FilterHelper {
    
    static func openFilter() -> FilterViewController {

        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: FilterViewController.identifier) as! FilterViewController

        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve

        return controller
    }
    
    static func openListFilter() -> ListFilterViewController {
        
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ListFilterViewController.identifier) as! ListFilterViewController
        
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        
        return controller
    }
    
}
