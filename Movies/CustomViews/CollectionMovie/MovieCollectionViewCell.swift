//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//
import UIKit
import RealmSwift
class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    var stateIsFavorite:Bool = false
    var movieObject = Movie()
    @IBOutlet weak var ImgViewMovie: UIImageView!
    @IBOutlet weak var BtnIsFavorite: UIButton!
    @IBOutlet weak var LblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BtnIsFavorite.addTarget(self, action: #selector(actionClickOption(_:)), for: .touchUpInside)
        
    }
    
    @objc func actionClickOption(_ sender : UIButton){
        stateIsFavorite = !stateIsFavorite
        
        var imageFavorite = ""
        if(stateIsFavorite){
            imageFavorite = "favorite_full_icon"
            if(movieObject.title != ""){
                RealmService.shared.add(movieObject)
            }
        }else{
            imageFavorite = "favorite_gray_icon"
        }
        BtnIsFavorite.setImage(UIImage(named: imageFavorite), for: .normal)
        BtnIsFavorite.isUserInteractionEnabled = false
    }
    
    
}
