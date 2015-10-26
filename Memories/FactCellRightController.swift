//
//  FactCellRightController.swift
//  Memories
//
//  Created by Thiago Gallego on 21/07/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//



//CÉLULA APAGADA

import UIKit

class FactCellRightController: UITableViewCell {

    @IBOutlet var photoView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var audioButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
