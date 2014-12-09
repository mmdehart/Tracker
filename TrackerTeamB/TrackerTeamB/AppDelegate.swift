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
    
    
    /*
     *  CURRRENT COUNTS
     */
    
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
    
    
    
    
    /*
     *  CURRENT TIME SPENT
     */
    func getDayTimeSpent() -> Int {
        var count = getTodayCount()
        return count * 5
    }
    
    func getWeekTimeSpent() -> Int {
        var count = getWeekCount()
        return count * 5
    }
    
    func getMonthTimeSpent() -> Int {
        var count = getMonthCount()
        return count * 5
    }
    
    func getYearTimeSpent() -> Int {
        var count = getYearCount()
        return count * 5
    }
    
    
    
    /*
     *  CURRENT AVG TIME BTW
     */
    
    
    
    /*
     *  CURRENT AVERAGES
     */
    func getTodayAverage() -> Double {
        //Need to get the count of cigs in a each hour and divide it by the amount of hours where cigarettes have been smoked (JK)
        var count:Int = 0
        var average:Double = 0.0
        var hourCount:Double = 0.0
        let today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .HourCalendarUnit | .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        var hourLimit:Int = 0
        
        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
        for var i = cigData.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = cigData[i].getCigDate()
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            hourLimit = 1
            if(todayComp.day == otherComp.day && todayComp.month == otherComp.month && todayComp.year == otherComp.year) {
                if (todayComp.hour == otherComp.hour) {
                    count++
                    println("The Count is:")
                    println(count)
                        //if this hour has been indexed, wait to index until the  next hour. (JK)
                    if (hourCount < Double(hourLimit)) {
                        hourCount++
                        println("The hour Count is:")
                        println(hourCount)
                        
                    }
                    if (hourLimit != Int(hourCount)) {
                        hourLimit++
                        println("The hour Limit is:")
                        println(hourLimit)
                    }
                    //This will reset the hour counter when we go past a single day
                    if (hourLimit > 24) {
                        hourLimit = 0
                    }
                }
            
                 //This is the count per hour? Need to see data from more than one hour span. (JK)
          //      println(hourCount)
                
            }
            else {
                return hourCount
            }
        }
        
        if (count != 0) {
            var average = (Double(count)/(hourCount))
            
            return average
        }
        return average
    }
    
    func getWeeklyAverage() ->Double {
        //Get the number cigs smoked within a week period, counting the number of days within the week that a cigg has been smoked.
        var count:Int = 0
        var average:Double = 0.0
        var dayCount:Double = 0.0
        let today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .HourCalendarUnit | .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        var dayLimit:Int = 0
        
        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
        for var i = cigData.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = cigData[i].getCigDate()
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            if(NSDate().timeIntervalSinceDate(thisDate) <= 604800) {
                    count++
                    //if this day has been indexed, wait to index until the  next day. (JK)
                    if (todayComp.day == otherComp.day) {
                        dayCount++
                        println(dayCount)
                        dayLimit++
                        //This will reset the weekly average when we go past a single week
                        if (dayLimit > 7) {
                            dayLimit = 0
                        }
                    }
                
                //This is the count per hour? Need to see data from more than one hour span. (JK)
        //        println(dayCount)
                
            }
            else {
                return dayCount
            }
        }
        
        if (count != 0) {
            var average = (Double(count)/(dayCount))
            
            return average
        }
        return average
    }
  
    func getMonthlyAverage() ->Double {
        //Get the number cigs smoked within a month period, counting the number of weeks within the month that a cigg has been smoked.
        var count:Int = 0
        var average:Double = 0.0
        var weekCount:Double = 0.0
        let today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .MonthCalendarUnit | .YearCalendarUnit
        var weekLimit:Int = 0
        
        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
        for var i = cigData.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = cigData[i].getCigDate()
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            if(todayComp.month == otherComp.month && todayComp.year == otherComp.year) {
                count++
                var endWeek = otherComp.day + 7
                var beginWeek = otherComp
                
                //if this week has been indexed, wait to index until the  next week. (JK)
                if (beginWeek != endWeek) {
                    weekCount++
                    weekLimit++
                    beginWeek.day + 1
                    //This will reset the monthly average when we go past a single month
                    if (weekLimit > 30) {
                        weekLimit = 0
                    }
                }
                
                //This is the count per week Need to see data from more than one week span. (JK)
       //         println(weekCount)
                
            }
            else {
                return weekCount
            }
        }
        
        if (count != 0) {
            var average = (Double(count)/(weekCount))
            
            return average
        }
        return average
    }
    
    func getYearlyAverage() ->Double {
        //Need to grab the amount of months cigs have been smoked and the amount of cigs
        var count:Int = 0
        var average:Double = 0.0
        var monthCount:Double = 0.0
        let today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .YearCalendarUnit
        var monthLimit:Int = 1
        
        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
        for var i = cigData.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = cigData[i].getCigDate()
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            if(todayComp.year == otherComp.year) {
                if (todayComp.month == otherComp.month) {
                    count++
                    println("The Count is:")
                    println(count)
                    //if this hour has been indexed, wait to index until the  next hour. (JK)
                    if (monthCount < Double(monthLimit)) {
                        monthCount++
                        println("The month Count is:")
                        println(monthCount)
                        
                    }
                    if (monthLimit != Int(monthCount)) {
                        monthLimit++
                        println("The month Limit is:")
                        println(monthLimit)
                    }
                    //This will reset the hour counter when we go past a single day
                    if (monthLimit > 24) {
                        monthLimit = 0
                    }
                }
                //This is the count per month Need to see data from more than one month span. (JK)
                println(monthCount)
                
            }
            else {
                return monthCount
            }
        }
        
        if (count != 0) {
            var average = (Double(count)/(monthCount))
            
            return average
        }
        return average
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