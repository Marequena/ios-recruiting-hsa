//
//  ColorExtensions.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func create(_ red: CGFloat,
                       _ green: CGFloat,
                       _ blue: CGFloat,
                       _ alplha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alplha)
    }
    
    fileprivate func getRGBAComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var (red, green, blue, alpha) = (CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0))
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    func alpha(_ alpha: CGFloat) -> UIColor {
        let comps = self.getRGBAComponents()
        return UIColor(red: comps.red,
                       green: comps.green,
                       blue: comps.blue, alpha: alpha)
    }
}
