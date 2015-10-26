//
//  ShowSummaryVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class ShowSummaryVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var sectionTitleArray : NSMutableArray = NSMutableArray()
    var sectionContentDict : NSMutableDictionary = NSMutableDictionary()
    var arrayForBool : NSMutableArray = NSMutableArray()
    
    var familiesData : [Family]!;

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var registerFamilyBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        // Do any additional setup after loading the view.
    
        arrayForBool = ["0","0"]
        sectionTitleArray = ["2014","2015"]
        var tmp1 : NSArray = ["Meu niver","Viagem ao México","Clarinha quebrou o dente","Dengoso morreu"]
        var string1 = sectionTitleArray .objectAtIndex(0) as? String
        [sectionContentDict .setValue(tmp1, forKey:string1! )]
        var tmp2 : NSArray = ["Minha netinha passou de ano","Carlos nasceu","Minha casa nova"]
        string1 = sectionTitleArray .objectAtIndex(1) as? String
        [sectionContentDict .setValue(tmp2, forKey:string1! )]
        
        

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        collectionView!.registerNib(UINib(nibName: "SummaryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "collCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //Implements TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if(arrayForBool .objectAtIndex(section).boolValue == true)
        {
            var tps = sectionTitleArray.objectAtIndex(section) as! String
            var count1 = (sectionContentDict.valueForKey(tps)) as! NSArray
            return count1.count
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ABC"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(arrayForBool .objectAtIndex(indexPath.section).boolValue == true){
            return 50
        }
        
        return 2;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        headerView.backgroundColor = UIColor(red: 171/255, green: 200/255, blue: 226/255, alpha: 1.0)
        headerView.tag = section
        headerView.layer.cornerRadius = 10
        headerView.layer.masksToBounds = true

        
        let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
        headerString.text = sectionTitleArray.objectAtIndex(section) as? String
        headerString.textColor = UIColor.whiteColor()
        headerView .addSubview(headerString)
        
        let headerTapped = UITapGestureRecognizer (target: self, action:"sectionHeaderTapped:")
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
    }
    
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
        println("Tapping working")
        println(recognizer.view?.tag)
        
        var indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        if (indexPath.row == 0) {
            
            var collapsed = arrayForBool .objectAtIndex(indexPath.section).boolValue
            collapsed       = !collapsed;
            
            arrayForBool .replaceObjectAtIndex(indexPath.section, withObject: collapsed)
            //reload specific section animated
            var range = NSMakeRange(indexPath.section, 1)
            var sectionToReload = NSIndexSet(indexesInRange: range)
            self.tableView .reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.Fade)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let CellIdentifier = "Cell"
        var cell :UITableViewCell
        cell = self.tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! UITableViewCell
        
        var manyCells : Bool = arrayForBool .objectAtIndex(indexPath.section).boolValue
        
        if (!manyCells) {
            //  cell.textLabel.text = @"click to enlarge";
        }
        else{
            var content = sectionContentDict .valueForKey(sectionTitleArray.objectAtIndex(indexPath.section) as! String) as! NSArray
            cell.textLabel?.text = content .objectAtIndex(indexPath.row) as? String
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 180/255, alpha: 1.0)
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
        }
        
        return cell
    }

    
    
    
    
    //Implements CollectionView
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return familiesData.count;
    }
    
    
    
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let collCell: SummaryCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("collCell", forIndexPath: indexPath) as! SummaryCollectionCell
        
        var cellImg = collCell.viewWithTag(1) as! UIImageView;
        
        collCell.summaryImgCell.image = UIImage(contentsOfFile: familiesData[indexPath.row].photo);
        collCell.descriptionLbl.text = familiesData[indexPath.row].subtitle;
        
        /*var cellImg = collCell.viewWithTag(1) as! UIImageView
        
        collCell.summaryImgCell.image = UIImage(named: "bird")
        
        collCell.descriptionLbl.text = "text"
        */
        
//        collCell.backgroundColor
        
        
        
        //Set a circular imageView

        collCell.summaryImgCell.layer.borderWidth = 2
        collCell.summaryImgCell.layer.masksToBounds = false
        collCell.summaryImgCell.layer.borderColor = UIColor(red: 171/255, green: 200/255, blue: 226/255, alpha: 1.0).CGColor
        collCell.summaryImgCell.layer.cornerRadius = collCell.frame.size.height/3
        collCell.summaryImgCell.clipsToBounds = true
        
        
        
        return collCell
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let dao = DAOFamily();
        familiesData = dao.getDataArray();
        collectionView.reloadData();
    }

    
    //Segue button to RegisterFamilyVC
    @IBAction func segueToRegisterFamily(sender: AnyObject) {
    
         
        let rfVC = RegisterFamilyVC(nibName: "RegisterFamilyVC", bundle: nil)

        //pieVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        presentViewController(rfVC, animated: true, completion: nil)
    
    }
    
    
    @IBAction func presentShowFactVC(sender: AnyObject) {
    
    let sfVC = ViewController(nibName: "ViewController", bundle: nil)
        sfVC.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        presentViewController(sfVC, animated: true, completion: nil)

    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
