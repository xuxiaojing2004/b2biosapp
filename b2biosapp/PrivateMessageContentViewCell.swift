//
//  PrivateMessageContentViewCell.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/24/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import UIKit

class PrivateMessageContentViewCell: UITableViewCell {

    @IBOutlet weak var contentWebView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
