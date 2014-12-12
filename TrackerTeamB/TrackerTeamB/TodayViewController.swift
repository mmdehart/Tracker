//
//  TodayViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import Foundation

class TodayViewController: UIViewController, CloudKitDelegate {
//class TodayViewController: UIViewController {

    var model : cloudKitData!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var timeSince: UILabel!
    
    var appDelegate:AppDelegate!
    
    var timer = NSTimer()
    var startDate = NSDate()
    
    var airplaneMode = false
    
    
//    let dateFormatter = NSDateFormatter()
//    let timeFormatter = NSDateFormatter() ???maybe
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let today = NSDate()
        
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        model = appDelegate.getCloudData()
        model.delegate = self
        model.getTodayRecs()
        model.grabGoal(false, newGoal: 0)
        
    
//        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
//        todayDate.text = dateFormatter.stringFromDate(today)

//        countLabel.text = "\(appDelegate.getTodayCount())"
        
//        if appDelegate.getTotalCigCount() != 0 {

//            var timesince = appDelegate.getTimeSinceLast()
//            timeSince.text = "\(timesince)"
//        }
//        else {
//            timeSince.text = "0"

//        }
    
    }

    override func viewWillAppear(animated: Bool) {
//        countLabel.text = String(model.testrecords.count + 1)
        countLabel.text = String(model.todayCount)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func plusButtonPressed(sender: UIButton) {
        
        if(self.airplaneMode) {
            let message = "Once you refain connection to iCloud, you can edit this entry"
            let alert = UIAlertView(title: "Notice: You're in Airplane Mode", message: message, delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            model.saveToPhone()
        }
        else {
            model.saveToCloud(NSDate())
        }
        var count: Int = NSString(string: countLabel.text!).integerValue
        count = count + 1
        countLabel.text = "\(count)"
        // start/reset timer
        self.startDate = NSDate()
        let aSelector:Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
        
//        if appDelegate.getTotalCigCount() != 0 {
//            var timesince = appDelegate.getTimeSinceLast()
//            timeSince.text = "\(timesince)"
//        }
//        appDelegate.addCig()
//        
//        countLabel.text = "\(appDelegate.getTodayCount())"
        
    }
    
    
    
    
    /* Delegate function is defined here but is actually a part of cloudData.swift
    This function displays an error if the user is not connected to the internet */
    func errorUpdating(error: NSError) {
        // Error Code 4 is Network Failure
        if error.code == 4
        {
            let message = "You do not have internet access. Now Entering AirPlane Mode."
            let alert = UIAlertView(title: "Error Loading Cloud Data.",
                message: message, delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
            // Error Code 9 is iCloud Not Setup
        else if error.code == 9
        {
            let message = "Please go to iPhone Settings->iCloud and sign in."
            let alert = UIAlertView(title: "This App Requires iCloud",
                message: message, delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        // Display Airplane Mode
//        activityIndicatorView.stopAnimating()
//        countLabel.text = "00"
        self.startDate = NSDate()
        let aSelector:Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
//        plusButton.enabled = true
        //set Airplane Mode
        self.airplaneMode = true
//         self.view.backgroundColor = UIColor.blackColor()
//        self.tabBarController?.tabBar.userInteractionEnabled = false
        
        return
    }
    
    /* Delegate function is defined here but is actually declared in cloudData.swift
    This function updates the count with an NSDate argument in order to update the Timer */
    func countUpdated(timeOfLastCig:NSDate) {
//        countLabel.text = String(model.testrecords.count)
        countLabel.text = String(model.todayCount)
//        NSLog("Upon Load 'Today's Count' has been updated to: \(model.testrecords.count)")
        NSLog("Upon Load 'Today's Count' has been updated to: \(model.todayCount)  \(model.testrecords.count)")
//        activityIndicatorView.stopAnimating()
//        plusButton.enabled = true
//        self.tabBarController?.tabBar.userInteractionEnabled = true
//         initiate timer (Uses starDate from today if there is a record, else calls grabLastCig)
        self.startDate = timeOfLastCig
//         listen for when the data comes back
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "grabLastCig", name: "fetchLastRecord", object: nil)
        let aSelector:Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
//         refresh Today Widget values
//        let sharedDefaults = NSUserDefaults(suiteName: "group.TrackerTeamA")
//        sharedDefaults?.setObject(model.dailyRecords.count, forKey: "count")
//        sharedDefaults?.synchronize()
    }
    
    
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

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        (segue.destinationViewController as EditTableViewController).detailItems = cigarettes
//        
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    
//    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    RecipeDetailViewController *destViewController = segue.destinationViewController;
//    destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
//    
//    // Hide bottom tab bar in the detail view
//    destViewController.hidesBottomBarWhenPushed = YES;
//    }
//    }
}
