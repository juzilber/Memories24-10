//
//  ViewController.swift
//  Memories
//
//  Created by Thiago Gallego on 27/07/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController : UIPageViewController!

    //THIS
    var pageFacts: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //THIS
        self.pageFacts = NSArray(objects: "0", "1", "2", "3", "4")
        
        self.pageViewController = PageViewController(nibName:"PageViewController", bundle: NSBundle.mainBundle())
        
        self.pageViewController.dataSource = self
        
        var startVC = self.viewControllerAtIndex(0) as ShowFactVC
        var viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = self.view.bounds
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
    }
    
    func viewControllerAtIndex(index: Int) -> ShowFactVC
    {
        
        if ((self.pageFacts.count == 0) || (index >= self.pageFacts.count))
        {
            return ShowFactVC()
            
        }
        
        var vc = ShowFactVC(nibName: "ShowFactVC", bundle: NSBundle.mainBundle())
        
        //THIS - se eu quiser alterar algo em show fact a partir daqui
        
        vc.pageIndex = index
        
        return vc
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! ShowFactVC
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound)
        {
            return nil
        }
        
        index++
        
        if (index == self.pageFacts.count)
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! ShowFactVC
        var index = vc.pageIndex as Int
        
        if ((index == 0) || index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}