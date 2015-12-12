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
    
        let rootPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        do{
            player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: rootPath.stringByAppendingPathComponent(audio)), fileTypeHint: nil)
        }
        catch{
            print("error init audio");
        }
    }
    
    override init(){
        super.init();
    }
}
