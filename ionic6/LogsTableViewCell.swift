//
//  LogsTableViewCell.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/7/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import UIKit

class LogsTableViewCell: UITableViewCell {

    @IBOutlet weak var studentName: UILabel!
    
    @IBOutlet weak var pickedUpBy: UILabel!
    @IBOutlet weak var timeIn: UILabel!
    
    @IBOutlet weak var timeOut: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
