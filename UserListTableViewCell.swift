//
//  UserListTableViewCell.swift
//  MyGate
//
//  Created by Venkatesh Naguru on 02/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
   
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var passcodeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
