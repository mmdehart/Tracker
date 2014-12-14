//
//  HistoryViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {

    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var histCount: UILabel!
    @IBOutlet weak var timeSpentLabel: UILabel!
    @IBOutlet weak var recordHigh: UILabel!
    @IBOutlet weak var avgAmtLabel: UILabel!
    @IBOutlet weak var recordLow: UILabel!
    
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var graphLabel: UILabel!
    

    var data: [NSDate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var max:Int = 5
        if let settings = defaults.objectForKey("dailyMax") as? Int {
            max = defaults.objectForKey("dailyMax") as Int
        }
        
        if let cigs = defaults.arrayForKey("cigLog") as [NSDate]? {
            data = defaults.arrayForKey("cigLog") as [NSDate]
        }
        
        maxLabel.text = "\(max)"
        histCount.text = "\(getTodayCount())"
        recordHigh.text = "Record High: \(getTodayMax())"
        recordLow.text = "Record Low: \(getTodayLow())"
        avgAmtLabel.text = "\(getTodayAverage())"
        timeSpentLabel.text = "\(getDayTimeSpent())"
        textLabel.text = "Today's Total"
        graphLabel.text = "Hourly"
        averageLabel.text = "Hourly Average"

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var max:Int = 5
        if let settings = defaults.objectForKey("dailyMax") as? Int {
            max = defaults.objectForKey("dailyMax") as Int
        }
        
        if let cigs = defaults.arrayForKey("cigLog") as [NSDate]? {
            data = defaults.arrayForKey("cigLog") as [NSDate]
        }
        
        segControl.selectedSegmentIndex = 0
        maxLabel.text = "\(max)"
        histCount.text = "\(getTodayCount())"
        recordHigh.text = "Record High: \(getTodayMax())"
        recordLow.text = "Record Low: \(getTodayLow())"
        avgAmtLabel.text = "\(getTodayAverage())"
        timeSpentLabel.text = "\(getTodayCount()) cigarettes | \(getDayTimeSpent()) minutes"
        textLabel.text = "Today's Total"
        graphLabel.text = "Hourly"
        averageLabel.text = "Hourly Average"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        var tempMax:Int = 5
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let settings = defaults.objectForKey("dailyMax") as? Int {
            tempMax = defaults.objectForKey("dailyMax") as Int
        }
        if let cigs = defaults.arrayForKey("cigLog") as [NSDate]? {
            data = defaults.arrayForKey("cigLog") as [NSDate]
        }
        
        switch segControl.selectedSegmentIndex {
        case 0:
            textLabel.text = "Today's Total"
            graphLabel.text = "Hourly"
            averageLabel.text = "Hourly Average"
            maxLabel.text = "\(tempMax)"
            histCount.text = "\(getTodayCount())"
            recordHigh.text = "Record High: \(getTodayMax())"
            recordLow.text = "Record Low: \(getTodayLow())"
            avgAmtLabel.text = "\(getTodayAverage())"
            timeSpentLabel.text = "\(getTodayCount()) cigarettes | \(getDayTimeSpent()) minutes"
            

        case 1:
            textLabel.text = "This Week"
            graphLabel.text = "Daily"
            averageLabel.text = "Daily Average"
            maxLabel.text = "\(tempMax * 7)"
            histCount.text = "\(getWeekCount())"
            recordHigh.text = "Record High: \(getWeeklyMax())"
            recordLow.text = "Record Low: \(getWeeklyLow())"
            avgAmtLabel.text = "\(getWeeklyAverage())"
            timeSpentLabel.text = "\(getWeekCount()) cigarettes | \(getWeekTimeSpent()) minutes"

            
            
        case 2:
            textLabel.text = "This Month"
            graphLabel.text = "Weekly"
            averageLabel.text = "Weekly Average"
            maxLabel.text = "\(tempMax * 30)"
            histCount.text = "\(getMonthCount())"
            recordHigh.text = "Record High: \(getMonthlyMax())"
            recordLow.text = "Record Low: \(getMonthlyLow())"
            avgAmtLabel.text = "\(getMonthlyAverage())"
            timeSpentLabel.text = "\(getMonthCount()) cigarettes | \(getMonthTimeSpent()) minutes"

            
        case 3:
            textLabel.text = "This Year"
            graphLabel.text = "Monthly"
            averageLabel.text = "Monthly Average"
            maxLabel.text = "\(tempMax * 365)"
            histCount.text = "\(getYearCount())"
            recordHigh.text = "Record High: \(getYearlyMax())"
            recordLow.text = "Record Low: \(getYearlyLow())"
            avgAmtLabel.text = "\(getYearlyAverage())"
            timeSpentLabel.text = "\(getYearCount()) cigarettes | \(getYearTimeSpent()) minutes"

            
        default:
            break;
        }
        
    }
    

    
    func getTodayCount() -> Int {
        var count = 0
        let today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        
        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
        for var i = data.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = data[i]
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
        
        for var i = data.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = data[i]
            if(NSDate().timeIntervalSinceDate(thisDate) <= 604800) {
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
        
        for var i = data.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = data[i]
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            if(todayComp.month == otherComp.month && todayComp.year == otherComp.year) {
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
        
        for var i = data.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = data[i]
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            if(todayComp.year == otherComp.year) {
                count++
            }
            else {
                return count
            }
        }
        return count
    }
    

    func getTodayAverage() -> Double {
        
        println("Start the Daily Average Function")
        
        //Need to get the count of cigs in a each hour and divide it by the amount of hours where cigarettes have been smoked (JK)
        var count:Int = data.count
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
            for (i=0;i<count;i++) {
                //Get hour Count
                if (data[i].timeIntervalSinceNow > beginHour && data[i].timeIntervalSinceNow < endHour) {
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
        
        var count:Int = data.count
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
            for (i=0;i<count;i++) {
                //Get hour Count
                if (data[i].timeIntervalSinceNow > beginDay && data[i].timeIntervalSinceNow < endDay) {
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
        
        var count:Int = data.count
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
            for (i=0;i<count;i++) {
                //Get hour Count
                if (data[i].timeIntervalSinceNow > beginWeek && data[i].timeIntervalSinceNow < endWeek) {
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
        var count:Int = data.count
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
            for (i=0;i<count;i++) {
                //Get hour Count
                if (data[i].timeIntervalSinceNow > beginMonth && data[i].timeIntervalSinceNow < endMonth) {
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
    
    
    func getTodayMax() ->Int {
        
        var count:Int = data.count
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
        var count:Int = data.count
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
        
        var count:Int = data.count
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
        var count:Int = data.count
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
        var count:Int = data.count
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
        var count:Int = data.count
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
        var count:Int = data.count
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
        var count:Int = data.count
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
    
    func getMax(begin:NSTimeInterval, end:NSTimeInterval, count:Int, maxCount: Int) ->Int {
        var i:Int = 0
        var max:Int = maxCount
        var timeFrameCount:Int = 0
        
        for (i=0; i<count; i++) {
            if(data[i].timeIntervalSinceNow > begin && data[i].timeIntervalSinceNow < end) {
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
            if (data[i].timeIntervalSinceNow > begin && data[i].timeIntervalSinceNow < end) {
                timeFrameCount++
            }
            if (timeFrameCount < low) {
                low = timeFrameCount
            }
        }
        return low
    }
    
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

}
