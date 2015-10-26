//
//  RegisterFactVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class RegisterFactVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var screenSize: CGRect!
    var screenHeight: CGFloat!
    var screenWidht: CGFloat!
  
    
    @IBAction func cancelButton(sender: AnyObject) {
        var controller: ViewController = ViewController(nibName:"ViewController", bundle:NSBundle.mainBundle())
        
        self.presentViewController(controller, animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registra as duas células diferentes
        var cellLeft = UINib(nibName: "RegFactCellLeft", bundle: nil)
        tableView.registerNib(cellLeft, forCellReuseIdentifier: "RegCellLeft")
        
        var cellRight = UINib(nibName: "RegFactCellRight", bundle: nil)
        tableView.registerNib(cellRight, forCellReuseIdentifier: "RegCellRight")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Calcula a altura da tela para definir a altura de cada célula
        screenSize = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        screenWidht = screenSize.width
        println("height: \(screenHeight) \nwidht: \(screenWidht)")
        configureRowHeight()
        
        //desabilita scroll, selection, separator
        tableView.scrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //cria gesture pra tocar na tableView e esconder o datePicker
        let tapGesture2 = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard2"))
        tapGesture2.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture2)
        
    }
    
    //esconde o keyboard quando toca na tableView
    func hideKeyboard2() {
        
        tableView.endEditing(true)
    }

    
    //Define 3 células por página
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    //Carrega as informações em cada célula e define que as de número par ficam na direita, as de número ímpar na esquerda
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //TODO: mudar depois para data só aparecer quando usuário clicar na foto. colocar um if, pra só preencher data se não tiver uma data prévia
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("ddMMyy", options: 0, locale: NSLocale(localeIdentifier: "pt_BR"))
        formatter.stringFromDate(date)
        
        if indexPath.row % 2 == 0 {
            var cell:RegFactCellRightController!
            cell = tableView.dequeueReusableCellWithIdentifier("RegCellRight", forIndexPath: indexPath) as! RegFactCellRightController
            
            cell.datePicker.text = "\(formatter.stringFromDate(date))"
            cell.subtitleTextView.text = "show do criolo na fundicao progresso um sucesso eta homem bom"
            var photo:UIImage = UIImage(named: "imageB")!
            cell.photoView.image = photo
            
            return cell
        } else {
            var cell:RegFactCellLeftController!
            cell = tableView.dequeueReusableCellWithIdentifier("RegCellLeft", forIndexPath: indexPath) as! RegFactCellLeftController
            
            cell.datePicker.text = "\(formatter.stringFromDate(date))"
            cell.subtitleTextView.text = "meu primo henrique olha como o sorriso dele é bonito ele é tao feliz"
            var photo:UIImage = UIImage(named: "imageB")!
            cell.photoView.image = photo
            
            return cell
        }
        
        
    }
    
    //Define a altura de cada célula
    func configureRowHeight() {
        tableView.rowHeight = screenHeight/3 - 18
        println(" rowHeight: \(tableView.rowHeight)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
