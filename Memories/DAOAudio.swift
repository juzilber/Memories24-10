//
//  DAOAudio.swift
//  Memories
//
//  Created by Mayara Gasparini Dias  on 27/07/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import Foundation

class DAOAudio: NSObject {
    
    class func createAudio(gameTitle: String) {
        let rootPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        //funcao para load plist
        let path : String = getPlistPath(rootPath)
        
        //abrir o arquivo e carregar a plist
        var audioArray : NSMutableArray! = NSMutableArray(contentsOfFile: path)
        
        //chave identificadora do audio
        var audioName : String = ""
        if audioArray == nil {
            audioArray = NSMutableArray()
            println("adad")
        }
        if audioArray.count == 0 {
            audioName = "0.caf"
        }
        var audioDict : NSMutableDictionary = NSMutableDictionary()
        audioDict.setValue(gameTitle, forKey: "AudioTitle")
        if audioName == "" {
            let count : Int = audioArray.count
            let lastAudioDict : NSMutableDictionary = audioArray[count-1] as! NSMutableDictionary
            let lastNumber : NSNumber = (lastAudioDict.valueForKey("index") as! NSNumber)
            let index : Int = lastNumber.integerValue + 1
            audioName = "\(index).caf"
            audioDict.setValue(audioName, forKey: "audioName")
            audioDict.setValue(index, forKey: "index")
        }
        else {
            audioDict.setValue(audioName, forKey: "audioName")
            audioDict.setValue(NSNumber(integer: 0), forKey: "index")
        }
        audioArray.addObject(audioDict)
        audioArray.writeToFile(path, atomically: false)
        let fileManager = NSFileManager.defaultManager()
        fileManager.copyItemAtPath(rootPath.stringByAppendingPathComponent("temp.caf"), toPath: rootPath.stringByAppendingPathComponent(audioName), error: nil)
        println(audioName)
    }
    
    /**************************************************************************/
    
    class func deleteAudio(index: Int) {
        var rootPath:NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        var path:NSString = rootPath.stringByAppendingPathComponent("DaoAudio.plist")
        var fileManager = NSFileManager.defaultManager()
        
        // Se o arquivo nao existir
        if (!fileManager.fileExistsAtPath(path as String)) {
            var sourcePath: String = NSBundle.mainBundle().pathForResource("DaoAudio", ofType: "plist")!;
            fileManager.copyItemAtPath(sourcePath, toPath: path as String, error: nil)
        }
        var audioArray : NSMutableArray! = NSMutableArray(contentsOfFile: path as String)
        let audioDict : NSDictionary = audioArray[index] as! NSDictionary
        let audioName : String = audioDict.valueForKey("audioName") as! String
        fileManager.removeItemAtPath(rootPath.stringByAppendingPathComponent(audioName), error:nil)
        audioArray.removeObjectAtIndex(index)
        audioArray?.writeToFile(path as String, atomically: false)
    }
    
    /************************************************************************/
    
    //funcao q pega da plist e salva
    class func getAllAudio() -> [DAOAudio] {
        var rootPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let path : String = getPlistPath(rootPath)
        var audioArray : NSMutableArray! = NSMutableArray(contentsOfFile: path)
        var audioDict : NSMutableDictionary = NSMutableDictionary()
        if audioArray == nil || audioArray.count == 0 {
            return []
        }
        var audios : [DAOAudio] = []
        for var i = 0 ; i < audioArray.count; i++ {
            let dict : NSDictionary = audioArray[i] as! NSDictionary
            var audioName : String = dict.valueForKey("audioName") as! String
            audios.append(DAOAudio())
            //antes: DAOAudio(title, audioName: audioName))
        }
        return audios
    }
    
    //Funcao para pegar a plist
    private class func getPlistPath(rootPath: String) -> String {
        var path: String = rootPath.stringByAppendingPathComponent("DaoAudio.plist")
        var fileManager = NSFileManager.defaultManager()
        
        // Se o arquivo nao existir
        if (!fileManager.fileExistsAtPath(path)) {
            var sourcePath: String = NSBundle.mainBundle().pathForResource("DaoAudio", ofType: "plist")!;
            fileManager.copyItemAtPath(sourcePath, toPath: path, error: nil)
        }
        return path
    }
    // fecha classe
}