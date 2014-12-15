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
    
    
    @IBOutlet weak var barChart: UIWebView!
    
    var chartHTML: String!
    var max:Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let settings = defaults.objectForKey("dailyMax") as? Int {
            max = defaults.objectForKey("dailyMax") as Int
        }
        
        if let cigs = defaults.arrayForKey("cigLog") as [NSDate]? {
            data = defaults.arrayForKey("cigLog") as [NSDate]
        }
        
        webViewConfiguration()
        chartHTML = buildDayChartHTML()
        
        drawChart(chartHTML)
        
        maxLabel.text = "\(max)"
        histCount.text = "\(getTodayCount())"
        recordHigh.text = "Record High: 25"
        recordLow.text = "Record Low: 2"
        var average:Double = getTodayAverage()
        avgAmtLabel.text = String(format: "%.4f",average)
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
        recordHigh.text = "Record High: 25"
        recordLow.text = "Record Low: 2"
        var average:Double = getTodayAverage()
        avgAmtLabel.text = String(format: "%.4f",average)
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
            
            chartHTML = buildDayChartHTML()
            drawChart(chartHTML)
            
            textLabel.text = "Today's Total"
            graphLabel.text = "Hourly"
            averageLabel.text = "Hourly Average"
            maxLabel.text = "\(tempMax)"
            histCount.text = "\(getTodayCount())"
            recordHigh.text = "Record High: 25"
            recordLow.text = "Record Low: 2"
            var average:Double = getTodayAverage()
            avgAmtLabel.text = String(format: "%.4f",average)
            timeSpentLabel.text = "\(getTodayCount()) cigarettes | \(getDayTimeSpent()) minutes"
            

        case 1:
            
            chartHTML = buildWeekChartHTML()
            drawChart(chartHTML)
            
            textLabel.text = "This Week"
            graphLabel.text = "Daily"
            averageLabel.text = "Daily Average"
            maxLabel.text = "\(tempMax * 7)"
            histCount.text = "\(getWeekCount())"
            recordHigh.text = "Record High: 25"
            recordLow.text = "Record Low: 2"
            var average:Double = getWeeklyAverage()
            avgAmtLabel.text = String(format: "%.4f",average)
            timeSpentLabel.text = "\(getWeekCount()) cigarettes | \(getWeekTimeSpent()) minutes"

            
            
        case 2:
            
            chartHTML = buildMonthChartHTML()
            drawChart(chartHTML)
            
            textLabel.text = "This Month"
            graphLabel.text = "Weekly"
            averageLabel.text = "Weekly Average"
            maxLabel.text = "\(tempMax * 30)"
            histCount.text = "\(getMonthCount())"
            recordHigh.text = "Record High: 25"
            recordLow.text = "Record Low: 2"
            var average:Double = getMonthlyAverage()
            avgAmtLabel.text = String(format: "%.4f",average)
            timeSpentLabel.text = "\(getMonthCount()) cigarettes | \(getMonthTimeSpent()) minutes"

            
        case 3:
            
            chartHTML = buildYearChartHTML()
            drawChart(chartHTML)
            
            textLabel.text = "This Year"
            graphLabel.text = "Monthly"
            averageLabel.text = "Monthly Average"
            maxLabel.text = "\(tempMax * 365)"
            histCount.text = "\(getYearCount())"
            recordHigh.text = "Record High: 25"
            recordLow.text = "Record Low: 2"
            var average:Double = getYearlyAverage()
            avgAmtLabel.text = String(format: "%.4f",average)
            timeSpentLabel.text = "\(getYearCount()) cigarettes | \(getYearTimeSpent()) minutes"

            
        default:
            break;
        }
        
    }
    
    func drawChart(chartHTML: String) {
        barChart.loadHTMLString(chartHTML, baseURL: nil)
    }
    
    func webViewConfiguration() {
        barChart.scrollView.scrollEnabled = false
        barChart.scrollView.bounces = false
        barChart.opaque = false
    }
    
    func buildDayChartHTML() ->NSString {
        var dataArray: [Int] = [0,0,0,0,0,0]
        var i:Int = 0
        
        var hourFormatter: NSDateFormatter = NSDateFormatter()
        hourFormatter.dateFormat = "HH"
        
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        var today: NSDate = NSDate()
        var date: String = formatter.stringFromDate(today)
        
        var count:Int = 0
        
        for (i=0;i < data.count; i++) {
            var hourString: String = hourFormatter.stringFromDate(data[i])
            var dateString: String = formatter.stringFromDate(data[i])
            
            var hour:Int = hourString.toInt()!
            
            if (dateString == date) {
                count++
                
                switch hour {
                case 0..<4:
                    dataArray[0]++
                case 4..<8:
                    dataArray[1]++
                case 8..<12:
                    dataArray[2]++
                case 12..<16:
                    dataArray[3]++
                case 16..<20:
                    dataArray[4]++
                case 20..<24:
                    dataArray[5]++
                default:
                    break
                }
            }
        }
        
        var stringHTML: String = "<html><head><script type='text/javascript' src='https://www.google.com/jsapi'></script><script type='text/javascript'>google.load('visualization', '1', {packages:['corechart']});google.setOnLoadCallback(drawChart);function drawChart() { var data = google.visualization.arrayToDataTable([ ['Hour', 'Cigs', { role: 'style' } ], ['12am - 4am', \(dataArray[0]), 'color: white; opacity: 0.75'], ['4am - 8am', \(dataArray[1]), 'color: white; opacity: 0.75'], ['8am - 12pm', \(dataArray[2]), 'color: white; opacity: 0.75'], ['12pm - 4pm', \(dataArray[3]), 'color: white; opacity: 0.75'], ['4pm - 8pm', \(dataArray[4]), 'color: white; opacity: 0.75'], ['8pm - 12am', \(dataArray[5]), 'color: white; opacity: 0.75'] ]); var options = { width: '100%', height: '100%', legend: { position: 'none' }, bar: { groupWidth: '70%' }, backgroundColor: '#333333', backgroundColor: { strokeWidth: 0, fill: '#333333' }, chartArea: { left: 20, top: 10, width:'95%', height:'85%'}, fontSize: 8, Style: { color: 'white' }, hAxis: { textStyle:{color: '#FFF'} }, vAxis: { textStyle:{color: '#FFF'} } }; var chart = new google.visualization.ColumnChart(document.getElementById('chart_div')); chart.draw(data, options);}</script><style> #chart_div { position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px; color: white; }</style></head><body> <div id='chart_div'></div></body></html>"
        
        return stringHTML
        
    }
    
    func buildWeekChartHTML() ->NSString {
        var dataArray: [Int] = [0,0,0,0,0,0,0]
        var i:Int = 0
        
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        var yearFormatter: NSDateFormatter = NSDateFormatter()
        yearFormatter.dateFormat = "yyyy"
        var today: NSDate = NSDate()
        var currentYearString: String = yearFormatter.stringFromDate(today)
        var todayDate: String = formatter.stringFromDate(today)
        var todayDayNum: Int! = getDayOfWeek(todayDate)
        
        
        for (i=0;i < data.count; i++) {
            var dateString: String = formatter.stringFromDate(data[i])
            var yearString: String = yearFormatter.stringFromDate(data[i])
            
            var day:Int! = getDayOfWeek(dateString)
            
            for (var j = 0;j < todayDayNum; j++) {
                let calendar = NSCalendar.currentCalendar()
                let components = NSDateComponents()
                components.day = -j
                
                let dateToInclude = calendar.dateByAddingComponents(components, toDate: today, options: nil)
                var dateToGraph:String = formatter.stringFromDate(dateToInclude!)
                
                if (yearString == currentYearString && dateToGraph == dateString) {
                    
                    switch day {
                    case 1:
                        dataArray[0]++
                    case 2:
                        dataArray[1]++
                    case 3:
                        dataArray[2]++
                    case 4:
                        dataArray[3]++
                    case 5:
                        dataArray[4]++
                    case 6:
                        dataArray[5]++
                    case 7:
                        dataArray[6]++
                    default:
                        break
                    }
                }
            }
        }
        
        var stringHTML: String = "<html><head><script type='text/javascript' src='https://www.google.com/jsapi'></script><script type='text/javascript'>google.load('visualization', '1', {packages:['corechart']});google.setOnLoadCallback(drawChart);function drawChart() { var data = google.visualization.arrayToDataTable([ ['Day', 'Cigs', { role: 'style' }, 'Maximum' ], ['SUN', \(dataArray[0]), 'color: white; opacity: 0.75', \(max)], ['MON', \(dataArray[1]), 'color: white; opacity: 0.75', \(max)], ['TUE', \(dataArray[2]), 'color: white; opacity: 0.75', \(max)], ['WED', \(dataArray[3]), 'color: white; opacity: 0.75', \(max)], ['THU', \(dataArray[4]), 'color: white; opacity: 0.75', \(max)], ['FRI', \(dataArray[5]), 'color: white; opacity: 0.75', \(max)], ['SAT', \(dataArray[6]), 'color: white; opacity: 0.75', \(max)] ]); var options = { seriesType: 'bars', series: {1: {type: 'line'}}, width: '100%', height: '100%', legend: { position: 'none' }, bar: { groupWidth: '70%' }, backgroundColor: '#333333', backgroundColor: { strokeWidth: 0, fill: '#333333' }, chartArea: { left: 20, top: 10, width:'95%', height:'85%'}, fontSize: 8, Style: { color: 'white' }, hAxis: { textStyle:{color: '#FFF'} }, vAxis: { textStyle:{color: '#FFF'} } }; var chart = new google.visualization.ComboChart(document.getElementById('chart_div')); chart.draw(data, options);}</script><style>#chart_div { position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px;}</style></head><body> <div id='chart_div'></div></body></html>"
        
        return stringHTML
    }
    
    func buildMonthChartHTML() -> NSString {
        // This array stories the count of cigs for each month ([0] = Week 1 (1st-7th), [1] = Week 2 (8th-15th), etc.)
        var dataArray: [Int] = [0, 0, 0, 0, 0]
        
        // Formatter to get day from record
        var dayFormatter: NSDateFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "dd"
        // Formatter to get month from records
        var monthFormatter: NSDateFormatter = NSDateFormatter()
        monthFormatter.dateFormat = "MM"
        // Formatter to get year from records
        var yearFormatter: NSDateFormatter = NSDateFormatter()
        yearFormatter.dateFormat = "yyyy"
        
        // Get the year from today's date
        var today: NSDate = NSDate()
        var CurrentYearString: String = yearFormatter.stringFromDate(today)
        var CurrentMonthString: String = monthFormatter.stringFromDate(today)
        
        // Get string for last day of the current month
        var lastDayOfMonth: String = getLastDayOfMonth()
        
        
        // Add data stored in cloud
        for (var i = 0; i < data.count; i++) {
            
            // Get month and year strings from record's timestamp
            var DayString: String = dayFormatter.stringFromDate(data[i])
            var MonthString: String = monthFormatter.stringFromDate(data[i])
            var YearString: String = yearFormatter.stringFromDate(data[i])
            // Convert month string to int
            var day: Int = DayString.toInt()!
            
            // Check if record occurred in the current year
            if( YearString == CurrentYearString && MonthString == CurrentMonthString ) {
                
                // Increment index based upon day of the month
                switch day {
                case 1...7:
                    dataArray[0]++
                case 8...14:
                    dataArray[1]++
                case 15...21:
                    dataArray[2]++
                case 22...28:
                    dataArray[3]++
                default:
                    dataArray[4]++
                    break
                }
            }
        }
        
        var stringHTML: String = String()
        stringHTML = "<html><head><script type='text/javascript' src='https://www.google.com/jsapi'></script><script type='text/javascript'>google.load('visualization', '1', {packages:['corechart']});google.setOnLoadCallback(drawChart);function drawChart() { var data = google.visualization.arrayToDataTable([ ['Week', 'Cigs', { role: 'style' }, 'Maximum' ], ['1st - 7th', \(dataArray[0]), 'color: white; opacity: 0.75', \(max)], ['8th - 14th', \(dataArray[1]), 'color: white; opacity: 0.75', \(max)], ['15th - 21st', \(dataArray[2]), 'color: white; opacity: 0.75', \(max)], ['22nd - 28th', \(dataArray[3]), 'color: white; opacity: 0.75', \(max)], ['29th - \(lastDayOfMonth)', \(dataArray[4]), 'color: white; opacity: 0.75', \(max)] ]); var options = { seriesType: 'bars', series: {1: {type: 'line'}}, width: '100%', height: '100%', legend: { position: 'none' }, bar: { groupWidth: '70%' }, backgroundColor: '#333333', backgroundColor: { strokeWidth: 0, fill: '#333333' }, chartArea: { left: 20, top: 10, width:'95%', height:'85%'}, fontSize: 8, Style: { color: 'white' }, hAxis: { textStyle:{color: '#FFF'} }, vAxis: { textStyle:{color: '#FFF'} } }; var chart = new google.visualization.ComboChart(document.getElementById('chart_div')); chart.draw(data, options);}</script><style>#chart_div { position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px;}</style></head><body> <div id='chart_div'></div></body></html>"
        
        // Return HTML string
        return stringHTML
    }
    
    func buildYearChartHTML() -> NSString {
        
        // This array stories the count of cigs for each month ([0] = January, [1] = February, etc.)
        var dataArray: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        // Formatter to get month from record
        var monthFormatter: NSDateFormatter = NSDateFormatter()
        monthFormatter.dateFormat = "MM"
        // Formatter to get year from records
        var yearFormatter: NSDateFormatter = NSDateFormatter()
        yearFormatter.dateFormat = "yyyy"
        
        // Get the year from today's date
        var today: NSDate = NSDate()
        var CurrentYearString: String = yearFormatter.stringFromDate(today)
        
        // Add data stored in cloud
        for (var i=0;i<data.count;i++) {
            
            // Get month and year strings from record's timestamp
            var MonthString: String = monthFormatter.stringFromDate(data[i])
            var YearString: String = yearFormatter.stringFromDate(data[i])
            // Convert month string to int
            var month: Int = MonthString.toInt()!
            
            // Check if record occurred in the current year
            if( YearString == CurrentYearString ) {
                
                // Increment index based upon month of the year
                switch month {
                case 1:
                    dataArray[0]++
                case 2:
                    dataArray[1]++
                case 3:
                    dataArray[2]++
                case 4:
                    dataArray[3]++
                case 5:
                    dataArray[4]++
                case 6:
                    dataArray[5]++
                case 7:
                    dataArray[6]++
                case 8:
                    dataArray[7]++
                case 9:
                    dataArray[8]++
                case 10:
                    dataArray[9]++
                case 11:
                    dataArray[10]++
                case 12:
                    dataArray[11]++
                default:
                    break
                }
            }
        }
        var stringHTML: String = "<html><head><script type='text/javascript' src='https://www.google.com/jsapi'></script><script type='text/javascript'>google.load('visualization', '1', {packages:['corechart']});google.setOnLoadCallback(drawChart);function drawChart() { var data = google.visualization.arrayToDataTable([ ['Month', 'Cigs', { role: 'style' }, 'Maximum' ], ['JAN', \(dataArray[0]), 'color: white; opacity: 0.75', \(max)], ['FEB', \(dataArray[1]), 'color: white; opacity: 0.75', \(max)], ['MAR', \(dataArray[2]), 'color: white; opacity: 0.75', \(max)], ['APR', \(dataArray[3]), 'color: white; opacity: 0.75', \(max)], ['MAY', \(dataArray[4]), 'color: white; opacity: 0.75', \(max)],"
        stringHTML += "['JUN', \(dataArray[5]), 'color: white; opacity: 0.75', \(max)], ['JUL', \(dataArray[6]), 'color: white; opacity: 0.75', \(max)], ['AUG', \(dataArray[7]), 'color: white; opacity: 0.75', \(max)], ['SEP', \(dataArray[8]), 'color: white; opacity: 0.75', \(max)], ['OCT', \(dataArray[9]), 'color: white; opacity: 0.75', \(max)], ['NOV', \(dataArray[10]), 'color: white; opacity: 0.75', \(max)], ['DEC', \(dataArray[11]), 'color: white; opacity: 0.75', \(max)] ]); var options = { seriesType: 'bars', series: {1: {type: 'line'}}, width: '100%', height: '100%', legend: { position: 'none' }, bar: { groupWidth: '70%' }, backgroundColor: '#333333', backgroundColor: { strokeWidth: 0, fill: '#333333' }, chartArea: { left: 20, top: 10, width:'95%', height:'85%'}, fontSize: 8, Style: { color: 'white' }, hAxis: { textStyle:{color: '#FFF'} }, vAxis: { textStyle:{color: '#FFF'} } }; var chart = new google.visualization.ComboChart(document.getElementById('chart_div')); chart.draw(data, options);}</script><style>#chart_div { position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px;}</style></head><body> <div id='chart_div'></div></body></html>"
        return stringHTML
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
        var i=0
        
        average = Double(count)/24.0
        
        
        return average
    }
    
    func getWeeklyAverage() ->Double {
        //Get the number cigs smoked within a week period, counting the number of days within the week that a cigg has been smoked.
        
        
        var count:Int = data.count
        var average:Double = 0.0
        average = Double(count)/168.0
        
        
        
        return average
    }
    
    func getMonthlyAverage() ->Double {
        //Get the number cigs smoked within a month period, counting the number of weeks within the month that a cigg has been smoked.
        
        var count:Int = data.count
        var average:Double = 0.0

        average = Double(count)/720.0
        
        return average
    }
    
    func getYearlyAverage() ->Double {
        //Need to grab the amount of months cigs have been smoked and the amount of cigs
        var count:Int = data.count
        var average:Double = 0.0

        average = Double(count)/8760.0
        
        println("Ending the Yearly Average Function")
        
        
        return average
    }
    
    func getDayOfWeek(today:String)->Int? {
        
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let todayDate = formatter.dateFromString(today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
            let myComponents = myCalendar.components(.WeekdayCalendarUnit, fromDate: todayDate)
            let weekDay = myComponents.weekday
            return weekDay
        } else {
            return nil
        }
    }
    
    func getLastDayOfMonth() -> NSString {
        
        // Formatter to get month from record
        var monthFormatter: NSDateFormatter = NSDateFormatter()
        monthFormatter.dateFormat = "MM"
        // Formatter to get year from records
        var yearFormatter: NSDateFormatter = NSDateFormatter()
        yearFormatter.dateFormat = "yyyy"
        
        var today: NSDate = NSDate()
        var thisYear: String = yearFormatter.stringFromDate(today)
        var thisMonth: String = monthFormatter.stringFromDate(today)
        var month: Int = thisMonth.toInt()!
        var year: Int = thisYear.toInt()!
        var lastDayOfMonth: String = String()
        
        switch month {
        case 2:
            // Caculate if leap year for February
            if (year % 400 == 0) {
                lastDayOfMonth = "29th"
            } else if (year % 100 == 0) {
                lastDayOfMonth = "28th"
            } else if (year % 4 == 0) {
                lastDayOfMonth = "29th"
            } else {
                lastDayOfMonth = "28th"
            }
        case 1, 3, 5, 7, 8, 10, 12:
            lastDayOfMonth = "31st"
        case 4, 6, 9, 11:
            lastDayOfMonth = "30th"
            // ? for
        default:
            lastDayOfMonth = "?"
            break
        }
        return lastDayOfMonth
    }
    
/*
    func getTodayMax() ->Int {
        
        var count = data.count
        var hours:Array = [Int]([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
        var i:Int = 0
        var j:Int = 0
        var begin:NSTimeInterval = -1
        var end:NSTimeInterval = -3600
        var hour:NSTimeInterval = -3600
        let today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .HourCalendarUnit | .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        
        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
/*        for var i = data.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = data[i]
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            if(todayComp.day == otherComp.day && todayComp.month == otherComp.month && todayComp.year == otherComp.year) {
               if (
                
            }
            
        }
*/
        while (end >= -86400) {
            for (i=0;i < 24; i++) {
                for (j=0;j < count; j++) {
                    if (data[j].timeIntervalSinceNow > end) {
                    if (data[j].timeIntervalSinceNow < begin) {
                        hours[i] += 1
                        println(hours[i])
                    }
                    }
                }
            }
        
            begin += hour
            end += hour
        }
        
        
        var maxHour:Int = -1
        var maxValue:Int = -1
  /*      for (j=0;j<count;j++) {
            if (hours[j] > maxValue) {
                maxHour = j
                maxValue = hours[j]
            }
   */return 0
        }


/*    func getTodayLow() ->Int {
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
 */
    func getMax(begin:NSTimeInterval, end:NSTimeInterval, count:Int, maxCount: Int) ->Int {
        var i:Int = 0
        var max:Int = maxCount
        var timeFrameCount:Int = 0
        
        for (i=(count - 1); i>=0; i--) {
            if(data[i].timeIntervalSinceNow < end) {
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

}
