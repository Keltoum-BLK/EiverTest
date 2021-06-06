//
//  ListViewCell.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 06/06/2021.
//

import UIKit

class ListViewCell: UITableViewCell {

    
    
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var posterMovie: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var descMovie: UITextView!
    
    
    var list: [ListMovie] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
