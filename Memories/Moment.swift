//
//  Moment.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit
import AVFoundation

class Moment : NSObject{
    
    var id:Int!
    var subtitle:String = ""
    var audio:String?
    var player:AVAudioPlayer?
    
    
    init(_ audio: String){
    
    let rootPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
    player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: rootPath.stringByAppendingPathComponent(audio)), error: nil)
    }
    
    override init(){
        super.init();
    }
}
