//
//  userListTableViewCell.swift
//  ekattor_ios
//
//  Created by Creativeitem on 7/30/15.
//  Copyright (c) 2015 Creativeitem. All rights reserved.
//

import UIKit


class FavoriteViewCell: UITableViewCell {
    
    
    @IBOutlet var imageMovie: UIImageView!
    
    @IBOutlet var titleMovie: UILabel!
    
    @IBOutlet var yearMovie: UILabel!
    
    @IBOutlet var overviewMovie: UILabel!
    
    var ServiceMovie = MovieService()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(idMovie : Int){
        ServiceMovie.getMovieDet( idMovie: idMovie) { data, error in
            self.titleMovie.text = data?.original_title
            let url = URL(string: "https://image.tmdb.org/t/p/original" + (data?.poster_path)! ?? "")
            let dataimg = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            self.imageMovie.image = UIImage(data: dataimg!)
            self.overviewMovie.text = data?.overview
            self.yearMovie.text = data?.release_date.prefix(4).description
            
        }
    }
    
    
}
