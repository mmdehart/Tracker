//
//  TodayViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import Foundation

<<<<<<< HEAD
class TodayViewController: UIViewController, CloudKitDelegate {

    var model : cloudKitData!
=======
class TodayViewController: UIViewController {
>>>>>>> maybe
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var timeSince: UILabel!
//    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
<<<<<<< HEAD
    var appDelegate:AppDelegate!

    // Timer items
    var timer = NSTimer()
    var startDate = NSDate()
    // Airplane mode
    var airplaneMode = false
    var airplaneDate : NSDate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        model = appDelegate.getCloudData()
        model.delegate = self
        model.grabToday()
        model.grabGoal(false, newGoal: 5)
//        activitySpinner.startAnimating()
        plusBtn.enabled = false
//        self.tabBarController?.tabBar.userInteractionEnabled = false
        
    }
    
    override func viewWillAppear(animated: Bool) {

        let sharedDefaults = NSUserDefaults()
        self.airplaneDate = sharedDefaults.objectForKey("record") as NSDate?
        if (self.airplaneDate != nil)
        {
            model.saveToCloud(self.airplaneDate!)
            countLabel.text = String(model.dailyRecords.count+1)
        }
        // Clear Out the recent save from the Widget
        self.airplaneDate = nil
        sharedDefaults.setObject(nil, forKey: "record")
        sharedDefaults.synchronize()
=======
    var timer = NSTimer()
    var startDate = NSDate()
    
    var data: [NSDate] = []

    
    @IBAction func unwindBack(sender:UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let cigs = defaults.arrayForKey("cigLog") as [NSDate]? {
            data = defaults.arrayForKey("cigLog") as [NSDate]
        }
        
        data.sort({ $0.compare($1) == NSComparisonResult.OrderedDescending })
        
        countLabel.text = "\(getTodayCount())"

            self.startDate = data[0]
            let aSelector:Selector = "updateTime"
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let cigs = defaults.arrayForKey("cigLog") as [NSDate]? {
            data = defaults.arrayForKey("cigLog") as [NSDate]
        }
        
        data.sort({ $0.compare($1) == NSComparisonResult.OrderedDescending })
        
        countLabel.text = "\(getTodayCount())"
        
        
        
            self.startDate = data[0]
            let aSelector:Selector = "updateTime"
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
>>>>>>> maybe
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func plusButtonPressed(sender: UIButton) {
<<<<<<< HEAD
        // If airplane mode is enabled
//        if (self.airplaneMode)
//        {
//            let message = "Once you regain connection in iCloud, you can edit this entry."
//            let alert = UIAlertView(title: "Notice: You're in Airplane Mode",
//                message: message, delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
//            // Save Record to an array of objects locally to be used in GoalsTAB
//            model.saveToPhone()
//        }
//        else
//        {
            // Save Record to the cloud
            model.saveToCloud(NSDate())
//        }
        countLabel.text = String(model.dailyRecords.count + 1)
        // Increment count Label
//        var count: Int = NSString(string: countLabel.text!).integerValue
//        count = count + 1
//        countLabel.text = "\(count)"
        // start/reset timer
        self.startDate = NSDate()
        let aSelector:Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
=======
        
        self.startDate = NSDate()
        let aSelector:Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let cigs = defaults.arrayForKey("cigLog") as [NSDate]? {
            data = defaults.arrayForKey("cigLog") as [NSDate]
        }
        
        data.append(NSDate())
        
        defaults.setObject(data, forKey: "cigLog")
        defaults.synchronize()
        
        countLabel.text = "\(getTodayCount())"
        
>>>>>>> maybe
    }
    

    
    
    /* Delegate function is defined here but is actually a part of cloudData.swift
    This function displays an error if the user is not connected to the internet */
    
    func updateTime(){
        var now = NSDate()
        var elapsedTime:NSTimeInterval = now.timeIntervalSinceDate(self.startDate)
        let hours = UInt8(elapsedTime / (60.0*60.0))
        elapsedTime -= (NSTimeInterval(hours) * 60 * 60)
        
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let strHours:String = hours > 9 ? String(hours):"0\(String(hours))"
        let strMinutes:String = minutes > 9 ? String(minutes):"0\(String(minutes))"
        if (UInt8(elapsedTime) % 2 == 0){
            timeSince.text = "\(strHours):\(strMinutes)"
        }
        else {
            timeSince.text = "\(strHours) \(strMinutes)"
        }
    }

    func getTodayCount() -> Int {
        var count = 0
        let today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        
<<<<<<< HEAD
        // Display Airplane Mode
//        activitySpinner.stopAnimating()
//        countLabel.text = "0"
        self.startDate = NSDate()
        let aSelector:Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        plusBtn.enabled = true
        // set Airplane Mode
        self.airplaneMode = true
        // self.view.backgroundColor = UIColor.blackColor()
//        self.tabBarController?.tabBar.userInteractionEnabled = false
        
        return
    }
    
    /* Delegate function is defined here but is actually declared in cloudData.swift
    This function updates the count with an NSDate argument in order to update the Timer */
    func countUpdated(timeOfLastCig:NSDate) {
        countLabel.text = String(model.dailyRecords.count)
        NSLog("Upon Load 'Today's Count' has been updated to: \(model.dailyRecords.count)")
//        activitySpinner.stopAnimating()
        plusBtn.enabled = true
//        self.tabBarController?.tabBar.userInteractionEnabled = true
        // initiate timer (Uses starDate from today if there is a record, else calls grabLastCig)
        self.startDate = timeOfLastCig
        // listen for when the data comes back
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "grabLastCig", name: "fetchLastRecord", object: nil)
        let aSelector:Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        // refresh Today Widget values
        let sharedDefaults = NSUserDefaults()
        sharedDefaults.setObject(model.dailyRecords.count, forKey: "count")
        sharedDefaults.synchronize()
    }
=======
        let todayComp:NSDateComponents = calendar.components(flags, fromDate: NSDate())
        
        for var i = data.count - 1 ; i >= 0; i-- {
            var thisDate:NSDate = data[i]
            let otherComp:NSDateComponents = calendar.components(flags, fromDate: thisDate)
            if(todayComp.day == otherComp.day && todayComp.month == otherComp.month && todayComp.year == otherComp.year) {
                count++
            }
        }
        return count
    }
    

>>>>>>> maybe
    
    func grabLastCig()
    {
        self.startDate = model.lastRecord[0].date_NS
    }
    
    /* Function to create dynamic stopwatch feature by calculating days, hours, minutes and then displaying them. This function
    gets called by a Selector controlled by NSTimer. So this function literally gets called every second over and over again */
    func updateTime(){
        // get timestamp for right now
        var now = NSDate()
        // set time interval (in seconds) between now and last cigarette
        var elapsedTime:NSTimeInterval = now.timeIntervalSinceDate(self.startDate)
        // calculate number of days (60s/min*60min/hr*24hr) from elapsedTime (which is in seconds)
        let days = UInt8(elapsedTime / (60.0*60.0*24.0))
        // subtract that amount from the time
        elapsedTime -= (NSTimeInterval(days) * 60 * 60 * 24.0)
        // Repeat for hours and minutes
        let hours = UInt8(elapsedTime / (60.0*60.0))
        elapsedTime -= (NSTimeInterval(hours) * 60 * 60)
        
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        // using Ternary Operator, create String variables: for values 1-9, display a leading zero
        let strDays:String = days > 9 ? String(days):"0\(String(days))"
        let strHours:String = hours > 9 ? String(hours):"0\(String(hours))"
        let strMinutes:String = minutes > 9 ? String(minutes):"0\(String(minutes))"
        // build the label
        if (UInt8(elapsedTime) % 2 == 0){
            timeSince.text = "\(strDays):\(strHours):\(strMinutes)"
        }
        else {
            timeSince.text = "\(strDays) \(strHours) \(strMinutes)"
        }
    }
    

}
