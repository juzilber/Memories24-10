//
//  RegFactCellLeftController.swift
//  Memories
//
//  Created by Thiago Gallego on 23/07/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class RegFactCellLeftController: UITableViewCell {

    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var datePicker: UITextField!
    @IBOutlet var subtitleTextView: UITextView!
    @IBOutlet var audioButton: UIButton!
    
    
    @IBAction func textFieldEditing(sender: UITextField) {
        var datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.locale = NSLocale(localeIdentifier: "pt_BR")
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("ddMMyy", options: 0, locale: NSLocale(localeIdentifier: "pt_BR"))
        datePicker.text = dateFormatter.stringFromDate(sender.date)
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
