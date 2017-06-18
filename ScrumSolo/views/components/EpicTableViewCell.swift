//
//  EpicTableViewCell.swift
//  ScrumSolo
//
//  Created by Baoli Zhai on 17/06/2017.
//  Copyright © 2017 DreamStudio. All rights reserved.
//

import UIKit

class EpicTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onEdit(_ sender: Any) {
    }
    
}
