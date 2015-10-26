//
//  AppDelegate.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        var type = UIUserNotificationType.Badge | UIUserNotificationType.Alert | UIUserNotificationType.Sound;
        var setting = UIUserNotificationSettings(forTypes: type, categories: nil);
        UIApplication.sharedApplication().registerUserNotificationSettings(setting);
        UIApplication.sharedApplication().registerForRemoteNotifications();
        
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
  
        //Definir Root View Controller
        var registerCoverVC: RegisterCoverVC = RegisterCoverVC(nibName:"RegisterCoverVC", bundle: nil)
        var showFactVC: ShowFactVC = ShowFactVC(nibName:"ShowFactVC", bundle: nil)
        var registerFactVC: RegisterFactVC = RegisterFactVC(nibName:"RegisterFactVC", bundle: nil)
        var viewController: ViewController = ViewController(nibName:"ViewController", bundle: nil)
        window?.rootViewController = registerCoverVC

        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application:UIApplication){
    // Sent when the application is about to move from active tinactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let calendar:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let cal = NSCalendar.currentCalendar()
        let datefor = NSDate()
        let components = NSDateComponents()
        let comp = cal.components(.MonthCalendarUnit | .DayCalendarUnit | .YearCalendarUnit, fromDate: datefor)
        
        
        components.year = comp.year
        components.month = comp.month
        components.day = comp.day
        components.hour = 17
        components.minute = 00
        components.second = 00
        let date: NSDate = calendar.dateFromComponents(components)!
        
        let nextDate: NSDateComponents = NSDateComponents()
        nextDate.minute = 1
        let fireDateNotification: NSDate = cal.dateByAddingComponents(nextDate, toDate: date, options: NSCalendarOptions(0))!
        
        
        var localNotification: UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Entrar no App"
        localNotification.alertBody = "Volte e registre seus melhores momentos"
        localNotification.fireDate = fireDateNotification
        localNotification.repeatInterval = NSCalendarUnit.CalendarUnitDay
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

