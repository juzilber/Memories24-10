//
//  DAOFact.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//


import UIKit
import AVFoundation


private let _daoFact = DAOFact()


class DAOFact {
    
    class var sharedInstance: DAOFact {
        
        return _daoFact
        
    }
    
    //carregar plist
    //carregar fotos(perfil+background)
    //load plist, testar, save, excluir, edit
    
    
    private var contents : NSMutableDictionary!;
    
    private let factPath : String;
    
    private let factPathDoc : String;
    
    
    //inicializa a classe
    
    init(){
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String;
        
        factPathDoc = documentPath.stringByAppendingPathComponent("Fact")
        
        factPath = documentPath.stringByAppendingPathComponent("Fact/FactData.plist");
        
        println(factPath)
        
        let fileManager = NSFileManager.defaultManager();
        
        if(fileManager.fileExistsAtPath(factPathDoc)){
            
            contents = NSMutableDictionary(contentsOfFile: factPath);
            
        }
            
        else
            
        {
            
            fileManager.createDirectoryAtPath(factPathDoc, withIntermediateDirectories: false, attributes: nil, error: nil)
            
            createDict()
            
        }
        
    }
    
    private func createDict(){
        
        contents = NSMutableDictionary();
        
        contents.writeToFile(factPath, atomically: true);
        
    }
    
    //pegando as informacoes nome, titulo e imagens para salvar
    
    //funcao retorna um vetor de fact
    
    
    
    func getAllData() -> [Fact]{
        
        //instanciando a classe Fact(passando informacoes da classe para a plist)
        
        //vetor de facts que salva facts (pagina inteira)
        
        var facts : [Fact] = [Fact]()
        
        //percorre anos dentro de contents, meses dentro de ano e dias dentro de meses
        
        //        for (contentAno, meses) in contents{
        //            for (contentMes, dias) in meses as! NSMutableDictionary{
        //                for (contentDia, fatos) in dias as! NSMutableDictionary{
        //                    for fato in fatos as! NSMutableDictionary{
        //                        //celula com imagem+legenda+audio
        //                        var fact : Fact = Fact()
        //                        //carregando a foto
        //                        fact.photo = fato["photo"] as! [String]
        //                        //carregando a legenda
        //                        fact.subtitle = fato["subtitle"] as! String
        //                        // carregando audio
        //                        fact.audio = (fato["audio"] as! String)
        //                        fact.id = fato["id"] as! Int
        //                        fact.date = fato["date"] as! NSDate
        //                        facts.append(fact)
        //                    }
        //                }
        //
        //            }
        //
        //        }
        
        return facts;
        
    }
    
    
    //pegando os anos
    func getAllYears() -> [String]{
        
        
        return contents.allKeys as! [String];
        
        
    }
    //pegando os meses dentro daquele ano especifico
    func getAllMonthsInYear(year : String) -> [String]{
        
        return (contents[year] as! NSDictionary).allKeys as! [String]
        
    }
    
    func getFactsOfMonth(year : String, month : String) -> [Fact]{
        var photos = [Fact]();
        let dias = (contents[year] as! NSDictionary)[month] as! NSDictionary;
        for (contentDia, fotos) in dias as! NSMutableDictionary{
            
            for foto in fotos as! NSArray{
                //celula com imagem+legenda+audio
                
                var fact : Fact = Fact()
                
                //carregando a foto
                
                fact.photos = foto["photo"] as! [String]
                
                
                //carregando a legenda
                
                fact.subtitle = foto["subtitle"] as! String
                
                
                // carregando audio
                
                fact.audio = (foto["audio"] as! String)
                
                fact.date = (foto["date"] as! NSDate)
                
                fact.id = foto ["id"] as! Int
                photos.append(fact)
            }
        }
        return photos;
    }
    
    func saveNewFact(fact : Fact, imgs : [UIImage], audio : String){
        
        //var daoAudio : DAOAudio = DAOAudio()
        
        //salvando o fact (foto+legenda+audio)
            let photosStrings = saveDataImgToPath(imgs);
            fact.photos = photosStrings;
        var audioString = (fact.audio == nil) ? "" : fact.audio;
        let factDict = NSDictionary(objects: [fact.photos, fact.subtitle, audioString!, fact.date!] , forKeys: ["photo","subtitle","audio", "date"])
        
        var format = NSDateFormatter();
        //declarando ano mes e dia"yyyy-MM-dd"
        format.dateFormat = "yyyy";
        let year = format.stringFromDate(fact.date!);
        format.dateFormat = "MM";
        let month = format.stringFromDate(fact.date!);
        format.dateFormat = "dd";
        let day = format.stringFromDate(fact.date!);
        
        //organizando os fatos em ano mes e dia
        //        var ddd = (((contents[year] as! NSMutableDictionary)[month] as! NSMutableDictionary)[day] as! [NSMutableDictionary]);
        //        ddd.append(factDict);
        
        if contents.valueForKey(year) == nil {
            
            contents.setValue(NSMutableDictionary(), forKey: year)
        }
        
        var yearDict: NSMutableDictionary = contents[year] as! NSMutableDictionary
        
        if yearDict.valueForKey(month) == nil {
            
            yearDict.setValue(NSMutableDictionary(), forKey: month)
        }
        
        var monthDict: NSMutableDictionary = yearDict[month] as! NSMutableDictionary
        
        if monthDict.valueForKey(day) == nil {
            
            monthDict.setValue(NSMutableDictionary(), forKey: day)
        }
        
        var dayDict: NSMutableDictionary = monthDict[day] as! NSMutableDictionary
        
        if dayDict.valueForKey("Facts") == nil {
            
            dayDict.setValue(NSMutableArray(capacity: 1), forKey: "Facts")
        }
        
        var facts: NSMutableArray = dayDict["Facts"] as! NSMutableArray
        
        facts.addObject(factDict)
        
        contents.writeToFile(factPath, atomically: true);
        
        
    }
    
    private func saveDataImgToPath(imgs : [UIImage]) -> [String]{
        
        let fileManager = NSFileManager.defaultManager();
        var names = [String]();
        var nIndex = Int(0);
        let existingImages = fileManager.contentsOfDirectoryAtPath(factPathDoc, error: nil) as! [String];
        for img in imgs {
            //enquanto o indice existe
            var str = "\(nIndex).png"
            while(exists(str, vec: existingImages)){
                nIndex++;
                str = "\(nIndex).png"
            }
            UIImagePNGRepresentation(img).writeToFile(factPathDoc+"/"+str, atomically: true);
            names.append(str);
        }
        
        return names;
    }
    
    func exists(str : String, vec : [String]) -> Bool{
        for v in vec{
            if(str == v){
                return true;
            }
        }
        return false;
    }
    
}