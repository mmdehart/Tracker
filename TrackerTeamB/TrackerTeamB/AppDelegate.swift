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
    
    var cData:cloudKitData = cloudKitData()
    
    func getCloudData() -> cloudKitData {
        return cData
    }
    
    func getYearTimeSpent() -> Int {
        var count = 0
        return count
    }
    
    
    
    /*
     *  CURRENT AVG TIME BTW
     */
    
    
    
    /*
     *  CURRENT AVERAGES
     */
    func getTodayAverage() -> Double {
        
        println("Start the Daily Average Function")
        
        //Need to get the count of cigs in a each hour and divide it by the amount of hours where cigarettes have been smoked (JK)
        var count:Int = cData.dailyRecords.count
        var average:Double = 0.0
        var hourCount:Array = [Double]()
        var inHourCount:Double = 0.0
        var i:Int = 0
        var endHour:NSTimeInterval = 3600
        var beginHour:NSTimeInterval = 0
        
        if (count == 0) {
            println("There are no data elements in the database")
            return 0.0
        }
        
        while (endHour <= 86400) {
            for (i=0;i<=count;i++) {
                //Get hour Count
                if (cData.dailyRecords[i].date_NS.timeIntervalSinceNow > beginHour && cData.dailyRecords[i].date_NS.timeIntervalSinceNow < endHour) {
                    inHourCount++
                }
            }
            inHourCount = inHourCount/inHourCount
            hourCount.append(inHourCount)
            beginHour += endHour
            endHour += endHour
        }
        
        average = Double(count)/Double(hourCount.count)
        
        println("Ending the Daily Average Function")
        
        return average
    }
    
    func getWeeklyAverage() ->Double {
        //Get the number cigs smoked within a week period, counting the number of days within the week that a cigg has been smoked.
        
        println("Starting the Weekly Average Function")
        
        var count:Int = cData.monthlyRecords.count
        var average:Double = 0.0
        var dayCount:Array = [Double]()
        var inDayCount:Double = 0.0
        var i:Int = 0
        var endDay:NSTimeInterval = 86400
        var beginDay:NSTimeInterval = 0
        
        if (count == 0) {
            println("There are no data elements in the database")
            return 0.0
        }
        
        while (endDay <= 604800) {
            for (i=0;i<=count;i++) {
                //Get hour Count
                if (cData.dailyRecords[i].date_NS.timeIntervalSinceNow > beginDay && cData.dailyRecords[i].date_NS.timeIntervalSinceNow < endDay) {
                    inDayCount++
                }
            }
            inDayCount = inDayCount/inDayCount
            dayCount.append(inDayCount)
            beginDay += endDay
            endDay += endDay
        }
        
        average = Double(count)/Double(dayCount.count)
        
        println("Ending the Weekly Average Function")
        

        return average
    }
  
    func getMonthlyAverage() ->Double {
        //Get the number cigs smoked within a month period, counting the number of weeks within the month that a cigg has been smoked.
        println("Starting the Monthly Average Function")
        
        var count:Int = cData.monthlyRecords.count
        var average:Double = 0.0
        var weekCount:Array = [Double]()
        var inWeekCount:Double = 0.0
        var i:Int = 0
        var endWeek:NSTimeInterval = 604800
        var beginWeek:NSTimeInterval = 0
        
        if (count == 0) {
            println("There are no data elements in the database")
            return 0.0
        }
        
        while (endWeek <= 2629740) {
            for (i=0;i<=count;i++) {
                //Get hour Count
                if (cData.dailyRecords[i].date_NS.timeIntervalSinceNow > beginWeek && cData.dailyRecords[i].date_NS.timeIntervalSinceNow < endWeek) {
                    inWeekCount++
                }
            }
            inWeekCount = inWeekCount/inWeekCount
            weekCount.append(inWeekCount)
            beginWeek += endWeek
            endWeek += endWeek
        }
        
        average = Double(count)/Double(weekCount.count)
        
        println("Ending the Monthly Average Function")
        
        
        return average
    }
    
    func getYearlyAverage() ->Double {
        //Need to grab the amount of months cigs have been smoked and the amount of cigs
        println("Starting the Yearly Average Function")
        //Need to get the dates from the data source.
        var count:Int = cData.monthlyRecords.count
        var average:Double = 0.0
        var monthCount:Array = [Double]()
        var inMonthCount:Double = 0.0
        var i:Int = 0
        var endMonth:NSTimeInterval = 2629740
        var beginMonth:NSTimeInterval = 0
        
        if (count == 0) {
            println("There are no data elements in the database")
            return 0.0
        }
        
        while (endMonth <= 31560000) {
            for (i=0;i<=count;i++) {
                //Get hour Count
                if (cData.dailyRecords[i].date_NS.timeIntervalSinceNow > beginMonth && cData.dailyRecords[i].date_NS.timeIntervalSinceNow < endMonth) {
                    inMonthCount++
                }
            }
            inMonthCount = inMonthCount/inMonthCount
            monthCount.append(inMonthCount)
            beginMonth += endMonth
            endMonth += endMonth
        }
        
        average = Double(count)/Double(monthCount.count)
        
        println("Ending the Yearly Average Function")
        
        
        return average
    }
    
    
    var settingsData:SettingsData = SettingsData()
    
    func getSetData() -> SettingsData {
        return settingsData
    }
    
    func getTodayMax() ->Int {
        
        var count:Int = cData.dailyRecords.count
        var beginHour:NSTimeInterval = 0
        var endHour:NSTimeInterval = 3600
        var inHourCount:Int = 0
        var max:Int = 0
        while (endHour <= 86400) {
            max = getMax(beginHour, end: endHour, count: count, maxCount: max)
            beginHour += endHour
            endHour += endHour
        }
        
        return max
    }
    
    func getTodayLow() ->Int {
        var count:Int = cData.dailyRecords.count
        var beginHour:NSTimeInterval = 0
        var endHour:NSTimeInterval = 3600
        var inHourCount:Int = 0
        var low:Int = 0
        while (endHour <= 86400) {
            low = getLow(beginHour, end: endHour, count: count, lowCount: low)
            beginHour += endHour
            endHour += endHour
        }
        return low
    }
    
    func getWeeklyMax() ->Int {
        
        var count:Int = cData.dailyRecords.count
        var beginDay:NSTimeInterval = 0
        var endDay:NSTimeInterval = 86400
        var inDayCount:Int = 0
        var max:Int = 0
        while (endDay <= 604800) {
            max = getMax(beginDay, end: endDay, count: count, maxCount: max)
            beginDay += endDay
            endDay += endDay
        }
        
        return max
    }
    
    func getWeeklyLow() ->Int {
        var count:Int = cData.dailyRecords.count
        var beginDay:NSTimeInterval = 0
        var endDay:NSTimeInterval = 86400
        var inDayCount:Int = 0
        var low:Int = 0
        while (endDay <= 604800) {
            low = getLow(beginDay, end: endDay, count: count, lowCount: low)
            beginDay += endDay
            endDay += endDay
        }
        return low
    }
    
    func getMonthlyMax() ->Int {
        var count:Int = cData.monthlyRecords.count
        var beginWeek:NSTimeInterval = 0
        var endWeek:NSTimeInterval = 604800
        var inWeekCount:Int = 0
        var max:Int = 0
        var newMax:Int = max
        while (endWeek <= 2629740)  {
            max = getMax(beginWeek, end: endWeek, count: count, maxCount: max)
            beginWeek += endWeek
            endWeek += endWeek
        }
        return max
    }
    
    func getMonthlyLow() ->Int {
        var count:Int = cData.dailyRecords.count
        var beginWeek:NSTimeInterval = 0
        var endWeek:NSTimeInterval = 604800
        var inWeekCount:Int = 0
        var low:Int = 0
        while (endWeek <= 2629740) {
            low = getLow(beginWeek, end: endWeek, count: count, lowCount: low)
            beginWeek += endWeek
            endWeek += endWeek
        }
        return low
    }
    
    func getYearlyMax() ->Int {
        var count:Int = cData.monthlyRecords.count
        var beginMonth:NSTimeInterval = 0
        var endMonth:NSTimeInterval = 2629740
        var inMonthCount:Int = 0
        var max:Int = 0
        var newMax:Int = max
        while (endMonth <= 31560000)  {
            max = getMax(beginMonth, end: endMonth, count: count, maxCount: max)
            beginMonth += endMonth
            endMonth += endMonth
        }
        return max
    }
    
    func getYearlyLow() ->Int {
        var count:Int = cData.dailyRecords.count
        var beginMonth:NSTimeInterval = 0
        var endMonth:NSTimeInterval = 604800
        var inWeekCount:Int = 0
        var low:Int = 0
        while (endMonth <= 31560000) {
            low = getLow(beginMonth, end: endMonth, count: count, lowCount: low)
            beginMonth += endMonth
            endMonth += endMonth
        }
        return low
    }
    
    func getMax(begin:NSTimeInterval, end:NSTimeInterval, count:Int, maxCount:Int) ->Int {
        var i:Int = 0
        var max:Int = maxCount
        var timeFrameCount:Int = 0
        
        for (i=0;i<count;i++) {
            if (cData.allRecords[i].date_NS.timeIntervalSinceNow > begin && cData.allRecords[i].date_NS.timeIntervalSinceNow < end) {
                timeFrameCount++
            }
            if (timeFrameCount > max) {
                max = timeFrameCount
            }
        }
    return max
    }
    
    func getLow(begin:NSTimeInterval, end:NSTimeInterval, count:Int, lowCount:Int) ->Int {
        var i:Int = 0
        var low:Int = lowCount
        var timeFrameCount:Int = 0
        
        for (i=0;i<count;i++) {
            if (cData.allRecords[i].date_NS.timeIntervalSinceNow > begin && cData.allRecords[i].date_NS.timeIntervalSinceNow < end) {
                timeFrameCount++
            }
            if (timeFrameCount < low) {
                low = timeFrameCount
            }
        }
        return low
    }
    
//    var cigData:[CigaretteData] = []
//    
//    
//    // created this method to return the mapdata
//    func getCigData() ->[CigaretteData] {
//        return cigData
//    }
//    
//    func getTotalCigCount() -> Int {
//        return cigData.count
//    }
//    
//    func addCig() -> NSDate {
//        cigData.append(CigaretteData(cig:NSDate()))
//        return NSDate()
//    }
//    
//    func getTimeSinceLast() -> NSTimeInterval {
//        var lastdate:NSDate! = cigData.last?.getCigDate()
//        return NSDate().timeIntervalSinceDate(lastdate)
//    }
//    
//    
//    
//    /*
//     *  CURRRENT COUNTS
//     */
//    func getTodayCount() -> Int {
//        var count = 0
//        
//        for var i = cigData.count - 1 ; i >= 0; i-- {
//            var thisDate:NSDate = cigData[i].getCigDate()
//            if(NSDate().timeIntervalSinceDate(thisDate) <= 86400) {
//                count++
//            }
//            else {
//                return count
//            }
//        }
//        return count
//    }
//
//    func getWeekCount() -> Int {
//        var count = 0
//        
//        for var i = cigData.count - 1 ; i >= 0; i-- {
//            var thisDate:NSDate = cigData[i].getCigDate()
//            if(NSDate().timeIntervalSinceDate(thisDate) <= 604800) {
//                count++
//            }
//            else {
//                return count
//            }
//        }
//        return count
//    }
//    
//    func getMonthCount() -> Int {
//        var count = 0
//    
//        for var i = cigData.count - 1 ; i >= 0; i-- {
//            var thisDate:NSDate = cigData[i].getCigDate()
//            if(NSDate().timeIntervalSinceDate(thisDate) <= 2629740) {
//                count++
//            }
//            else {
//                return count
//            }
//        }
//        return count
//    }
//    
//    func getYearCount() -> Int {
//        var count = 0
//        
//        for var i = cigData.count - 1 ; i >= 0; i-- {
//            var thisDate:NSDate = cigData[i].getCigDate()
//            if(NSDate().timeIntervalSinceDate(thisDate) <= 31556700) {
//                count++
//            }
//            else {
//                return count
//            }
//        }
//        return count
//    }
//    
//  
//    
//    
//    /*
//     *  CURRENT TIME SPENT
//     */
//    func getDayTimeSpent() -> Int {
//        var count = getTodayCount()
//        return count * 5
//    }
//    
//    func getWeekTimeSpent() -> Int {
//        var count = getWeekCount()
//        return count * 5
//    }
//    
//    func getMonthTimeSpent() -> Int {
//        var count = getMonthCount()
//        return count * 5
//    }
//    
//    func getYearTimeSpent() -> Int {
//        var count = getYearCount()
//        return count * 5
//    }
//    
//    
//    
//    /*
//     *  CURRENT AVG TIME BTW
//     */
//    
//    
//    
//    /*
//     *  CURRENT AVERAGES
//     */
//    func getDailyAverage() {
//        
//    }
//    
//    
//    
//    var settingsData:SettingsData = SettingsData()
//    
//    func getSetData() -> SettingsData {
//        return settingsData
//    }
//    
    
    


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

//    func getTodayCount() -> Int {
//        var count = 0
//        let today = NSDate()
//        var calendar = NSCalendar.currentCalendar()
//        let flags:NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
//
//        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
//
//        for var i = cigData.count - 1 ; i >= 0; i-- {
//            var thisDate:NSDate = cigData[i].getCigDate()
//            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
//            if(todayComp.day == otherComp.day && todayComp.month == otherComp.month && todayComp.year == otherComp.year) {
//                count++
//            }
//            else {
//                return count
//            }
//        }
//        return count
//    }


//    func getMonthCount() -> Int {
//        var count = 0
//        let today = NSDate()
//        var calendar = NSCalendar.currentCalendar()
//        let flags:NSCalendarUnit = .MonthCalendarUnit | .YearCalendarUnit
//
//        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
//
//        for var i = cigData.count - 1 ; i >= 0; i-- {
//            var thisDate:NSDate = cigData[i].getCigDate()
//            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
//            if( todayComp.month == otherComp.month && todayComp.year == otherComp.year) {
//                count++
//            }
//            else {
//                return count
//            }
//        }
//        return count
//    }

//    func getYearCount() -> Int {
//        var count = 0
//        let today = NSDate()
//        var calendar = NSCalendar.currentCalendar()
//        let flags:NSCalendarUnit = .YearCalendarUnit
//
//        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
//
//        for var i = cigData.count - 1 ; i >= 0; i-- {
//            var thisDate:NSDate = cigData[i].getCigDate()
//            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
//            if( todayComp.year == otherComp.year) {
//                count++
//            }
//            else {
//                return count
//            }
//        }
//        return count
//    }

  
