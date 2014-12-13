//
//  TodayViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TodayViewController: UIViewController {

//    var managedContext : NSManagedObjectContext!
    
    var coreDataStack : CoreDataStack!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var timeSince: UILabel!
    
    var timer = NSTimer()
    var startDate = NSDate()
    
//    
//    lazy var managedObjectContext : NSManagedObjectContext? = {
//        let appDeletgate = UIApplication.sharedApplication().delegate as AppDelegate
//        if let managedObjectContext = appDeletgate.managedObjectContext {
//            return managedObjectContext
//        }
//        else {
//            return nil
//        }
//    }()
//    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let today = NSDate()
        
//        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        
    
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

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func plusButtonPressed(sender: UIButton) {
        

//        var count: Int = NSString(string: countLabel.text!).integerValue
//        count = count + 1
//        countLabel.text = "\(count)"
//        // start/reset timer
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
