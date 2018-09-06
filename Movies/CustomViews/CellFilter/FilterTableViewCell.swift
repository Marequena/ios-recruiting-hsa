//
//  FilterTableViewCell.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    static let identifier = "FilterTableViewCell"
    @IBOutlet weak var LblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
