//
//  ViewControllerExtensions.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

extension UIViewController{
    func clearHistoryNavigation(){
        if self.childViewControllers.count > 0{
            self.childViewControllers.forEach({ $0.willMove(toParentViewController: nil); $0.view.removeFromSuperview(); $0.removeFromParentViewController() })
        }
    }
    
}
