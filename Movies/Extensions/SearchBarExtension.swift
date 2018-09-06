//
//  SearchBarExtension.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

extension UISearchBar{
    
    func changeFont(placeholderText:String) {
        
        
        self.searchBarStyle = UISearchBarStyle.minimal
        self.isTranslucent = false
        self.barTintColor = contsColor.yellow
        self.backgroundColor = contsColor.yellow
        for view : UIView in (self.subviews[0]).subviews {
            
            if let textField = view as? UITextField {
//                textField.font = UIFont(name: "\(contsFonts.firstFamily)-\(contsFonts.styleBook)", size: CGFloat(contsFonts.sizeMediumSec))
                textField.textColor = contsColor.bluedark
                textField.placeholder = placeholderText
                textField.backgroundColor = contsColor.orange
                
            }
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
