//
//  CoverVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class CoverVC: UIViewController {
    


    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelName: UILabel!

    @IBOutlet var summaryBtn: UIButton!

    @IBOutlet var buttonImageCover: UIButton!
    @IBOutlet var imageProfile: UIImageView!
    
    var image : UIImage!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        buttonImageCover.setImage(image, forState: .Normal)

        var daoCover = DAOCover()
        let myCover = daoCover.getData();
        if(myCover != nil){
            
            println(myCover?.title)
            labelTitle.text = myCover?.title;
            labelName.text = myCover?.name;
            imageProfile.image = UIImage(contentsOfFile: myCover!.imageProfile)
            image = UIImage(contentsOfFile: myCover!.imageBackground);
            buttonImageCover.setImage(image, forState: .Normal);

            
        } else {
            println("salvou nada")
        }
        
        
        imageProfile.userInteractionEnabled = true
        imageProfile.layer.borderWidth = 1
        imageProfile.layer.masksToBounds = false
        imageProfile.layer.borderColor = UIColor.clearColor().CGColor
        imageProfile.layer.cornerRadius = imageProfile.frame.height/2
        imageProfile.clipsToBounds = true

        
        
    }
    
    //botao edit que leva pra RegisterCoverVC
    @IBAction func editCover(sender: AnyObject) {
        
     

        var controller: RegisterCoverVC = RegisterCoverVC(nibName:"RegisterCoverVC", bundle:NSBundle.mainBundle())
        
        
        self.presentViewController(controller, animated: false, completion: nil)
    }
    
   
    @IBAction func goToSummary(sender: AnyObject) {
        
        let ssVC = ShowSummaryVC(nibName: "ShowSummaryVC", bundle: nil)
    
        ssVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
    presentViewController(ssVC, animated: true, completion: nil)
    }
    

    }


