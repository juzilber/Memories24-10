//
//  DataAlbumCache.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class DataAlbumCache {
    
    var cover:[Cover]?
    var fact:[Fact]?
    var family:[Family]?
    
    class var sharedInstance:DataAlbumCache{
        get {
            struct _Singleton {
                static let instance = DataAlbumCache()
            }
            return _Singleton.instance
        }
    }
    
    private init(){
        println("Singleton 'Cache' instanciado.")
    }
    
    
    
    
    
    
    
    
    
}

