//
//  ViewExtension.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func showBlurLoader(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = contsColor.yellow
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        blurEffectView.tag = 100
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        
        self.addSubview(blurEffectView)
    }
    
    func removeBluerLoader(){
        if let viewWithTag = self.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    
}



