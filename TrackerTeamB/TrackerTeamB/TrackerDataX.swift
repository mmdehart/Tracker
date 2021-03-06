//
//  TrackerData.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/20/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

//
//  Tracker Data.swift
//  TrackerTeamB
//
//  Created by Eric Hayes on 11/18/14.
//  Copyright (c) 2014 Eric Hayes of University of Missouri. All rights reserved.
//

import UIKit

//model attempt for backend

class TrackerDataX: NSObject {//house data for week, month, year
    //start
    var TrackOfDay:DayInfo = DayInfo(amount:0, clock:"NOW", lastClock:"then", when:"Today")
    var TrackOfWeek:WeekInfo = WeekInfo(weekAmount:0, weekStart:"Sunday", dayNumber:1, weekNumber: 1)
    var TrackOfMonth:MonthInfo = MonthInfo(currentMonth:"November", monthAmount:0)
    var TrackOfYear:YearInfo = YearInfo(currentYear:"2014", yearAmount:0)
    
    //array with all info
    var myDataDay:[DayInfo]
    var myDataWeek:[WeekInfo]
    var myDataYear:[YearInfo]
    var myDataMonth:[MonthInfo]
    
    
    //initialized
    override init(){
        //myData = [DayInfo, WeekInfo, MonthInfo, YearInfo]
        myDataDay = [TrackOfDay]
        myDataWeek = [TrackOfWeek]
        myDataMonth = [TrackOfMonth]
        myDataYear = [TrackOfYear]
        
    }
    
}


//section for Current Day info, push info info at the end of day
class DayInfo: NSObject {
    var amount: Int //today's total
    var when: String
    var clock: String //time when button clicked
    //today's date
    var lastClock: String // last time button was clicked
    //whats being passed init
    init(amount: Int, clock: String, lastClock:String, when: String ){
        self.amount = amount
        self.clock = clock
        self.when = when
        self.lastClock = lastClock
    }
}

//section for Week info
class WeekInfo: NSObject{
    var weekAmount: Int //Total number tracked for week, week total builds as week goes on
    var weekStart: String//actual date of when week strts counting amount
    var dayNumber: Int //7 days in a week, after 7, start day count over
    var weekNumber: Int //52 weeks in a year, once 53 is hit, start week count over
    //whats being passed init
    init(weekAmount: Int, weekStart: String, dayNumber: Int, weekNumber: Int){
        self.weekAmount = weekAmount
        self.weekStart = weekStart
        self.dayNumber = dayNumber
        self.weekNumber = weekNumber
    }
}

//section for Month info
class MonthInfo: NSObject{
    var currentMonth: String
    var monthAmount: Int
    //whats being passed init
    init (currentMonth: String, monthAmount: Int){
        self.currentMonth = currentMonth
        self.monthAmount = monthAmount
    }
}

//section for Year info
class YearInfo: NSObject{
    var currentYear: String
    var yearAmount: Int
    //whats being passed
    init(currentYear: String, yearAmount: Int){
        self.currentYear = currentYear
        self.yearAmount = yearAmount
    }
    
}
