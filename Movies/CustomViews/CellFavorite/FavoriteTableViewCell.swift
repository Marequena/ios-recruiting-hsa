//
//  MovimentsTableViewCell.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    static let identifier = "FavoriteTableViewCell"
    
    @IBOutlet weak var ImgViewMovie: UIImageView!
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var LblModel: UILabel!
    @IBOutlet weak var TxtViewDescription: UITextView!
    
    override func awakeFromNib() {
        // Initialization code
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
