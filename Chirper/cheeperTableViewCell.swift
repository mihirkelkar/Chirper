//
//  cheeperTableViewCell.swift
//  Chirper
//
//  Created by Mihir Kelkar on 8/2/14.
//  Copyright (c) 2014 Mihir Kelkar. All rights reserved.
//

import UIKit
//  ****** TUTORIAL PART 5 ********
//Connect the table view cell to this custom class.
//Move to createChirps class for part 6

class cheeperTableViewCell: UITableViewCell {

    @IBOutlet var usernameLabel: UILabel
    @IBOutlet var timeStampLabel: UILabel
    @IBOutlet var chprView: UITextView
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
