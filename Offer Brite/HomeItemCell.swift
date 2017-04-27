//
//  HomeItemCell.swift
//  Offer Brite
//
//  Created by Ahsan Hameed on 4/20/17.
//  Copyright © 2017 VirtualBase. All rights reserved.
//

import UIKit

class HomeItemCell: UITableViewCell {

    @IBOutlet weak var backgroundCardview: UIView!
    @IBAction func followedBtn(_ sender: Any) {
    }
    @IBAction func likesBtn(_ sender: Any) {
    }
    @IBOutlet weak var likesBtnOL: UIButton!
    @IBOutlet weak var followedBtnOL: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCardview.layer.cornerRadius = 3.0
        backgroundCardview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        backgroundCardview.layer.shadowOpacity = 0.2
        backgroundCardview.layer.masksToBounds = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
