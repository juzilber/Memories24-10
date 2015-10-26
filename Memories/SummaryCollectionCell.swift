//
//  SummaryCollectionCell.swift
//  Memories
//
//  Created by Lidiane Souza on 7/23/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class SummaryCollectionCell: UICollectionViewCell {

    @IBOutlet var summaryImgCell: UIImageView!
    @IBOutlet var descriptionLbl: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override init(frame: CGRect) {
        summaryImgCell = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        
        
        descriptionLbl = UILabel(frame: CGRect(x: 0, y: summaryImgCell.frame.size.height, width: frame.size.width, height: frame.size.height/3))
        
        super.init(frame: frame)
        
        
        summaryImgCell.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(summaryImgCell)
       
        
        descriptionLbl.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        descriptionLbl.textAlignment = .Center
        contentView.addSubview(descriptionLbl)
    }

}
