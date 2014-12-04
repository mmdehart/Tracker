//
//  AppDelegate.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    
    var cigData:[CigaretteData] = []
    
    // created this method to return the mapdata
    func getCigData() ->[CigaretteData] {
        return cigData
    }
    
    func getTotalCigCount() -> Int {
        return cigData.count
    }
    
    func addCig() -> NSDate {
        cigData.append(CigaretteData(cig:NSDate()))
        return NSDate()
    }
    
    func getTimeSinceLast() -> NSTimeInterval {
        var lastdate:NSDate! = cigData.last?.getCigDate()
        return NSDate().timeIntervalSinceDate(lastdate)
    }
    
    func getTodayCount() -> Int {
        var count = 0
        let today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        
        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
        for var i = cigData.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = cigData[i].getCigDate()
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            if(todayComp.day == otherComp.day && todayComp.month == otherComp.month && todayComp.year == otherComp.year) {
                count++
            }
            else {
                return count
            }
        }
        return count
    }
    
    func getWeekCount() -> Int {
        var count = 0
//        let today = NSDate()
//        var calendar = NSCalendar.currentCalendar()
//        let flags:NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit | .WeekdayCalendarUnit
        
//        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
        for var i = cigData.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = cigData[i].getCigDate()
            if(NSDate().timeIntervalSinceDate(thisDate) <= 604800) {//yes, that is the number of seconds in a week...
                //apparently all the week functions for NSDate/Calendar are depricated..
                count++
            }
            else {
                return count
            }
        }
        return count
    }
    
    func getMonthCount() -> Int {
        var count = 0
        let today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .MonthCalendarUnit | .YearCalendarUnit
        
        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
        for var i = cigData.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = cigData[i].getCigDate()
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            if( todayComp.month == otherComp.month && todayComp.year == otherComp.year) {
                count++
            }
            else {
                return count
            }
        }
        return count

    }
    
    func getYearCount() -> Int {
        var count = 0
        let today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .YearCalendarUnit
        
        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
        for var i = cigData.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = cigData[i].getCigDate()
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            if( todayComp.year == otherComp.year) {
                count++
            }
            else {
                return count
            }
        }
        return count
        
    }
    
    
    
    var settingsData:SettingsData = SettingsData()
    
    func getSetData() -> SettingsData {
        return settingsData
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

