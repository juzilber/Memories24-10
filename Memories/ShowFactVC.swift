//
//  ShowFactVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class ShowFactVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var editButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var screenSize: CGRect!
    var screenHeight: CGFloat!
    var screenWidht: CGFloat!
    
    //THIS
    var pageIndex: Int!
    var id:Int!

    @IBAction func editFacts(sender: AnyObject) {
        var controller: RegisterFactVC = RegisterFactVC(nibName:"RegisterFactVC", bundle:NSBundle.mainBundle())
        
        self.presentViewController(controller, animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registra as duas células diferentes
        var cellLeft = UINib(nibName: "FactCellLeft", bundle: nil)
        tableView.registerNib(cellLeft, forCellReuseIdentifier: "CellLeft")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //Calcula a altura da tela para definir a altura de cada célula
        screenSize = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        screenWidht = screenSize.width
        println("height: \(screenHeight) \nwidht: \(screenWidht)")
        configureRowHeight()
            }

    
    //Define 3 células por página
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    //Carrega as informações em cada célula e define que as de número par ficam na direita, as de número ímpar na esquerda
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //índice de 0 a n que indica a posição da célula em relação a todas as outras
        id = indexPath.row + (pageIndex*3)
        
        var cell:FactCellLeftController!
        cell = tableView.dequeueReusableCellWithIdentifier("CellLeft", forIndexPath: indexPath) as! FactCellLeftController
        cell.dateLabel.text = "0 jan 00"
        cell.subtitleLabel.text = "meu primo henrique olha como o sorriso dele é bonito ele é tao feliz"
        var photo:UIImage = UIImage(named: "\(id)")!
        cell.photoView.image = photo

        return cell

    }
    
    
    //Define a altura de cada célula
    func configureRowHeight() {
        tableView.rowHeight = screenHeight/2 - 18
        println(" rowHeight: \(tableView.rowHeight)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
