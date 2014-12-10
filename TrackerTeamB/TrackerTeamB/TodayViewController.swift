//
//  TodayViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import Foundation

//class TodayViewController: UIViewController, CloudKitDelegate {
class TodayViewController: UIViewController {

    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var timeSince: UILabel!
    
    var appDelegate:AppDelegate!
    
    let dateFormatter = NSDateFormatter()
//    let timeFormatter = NSDateFormatter() ???maybe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = NSDate()
        
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        todayDate.text = dateFormatter.stringFromDate(today)

        countLabel.text = "\(appDelegate.getTodayCount())"
        
        if appDelegate.getTotalCigCount() != 0 {

            var timesince = appDelegate.getTimeSinceLast()
            timeSince.text = "\(timesince)"
        }
        else {
            timeSince.text = "0"

        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func plusButtonPressed(sender: UIButton) {
        if appDelegate.getTotalCigCount() != 0 {
            var timesince = appDelegate.getTimeSinceLast()
            timeSince.text = "\(timesince)"
        }
        appDelegate.addCig()
        
        countLabel.text = "\(appDelegate.getTodayCount())"
        
    }
    
    
    
    
    /* Delegate function is defined here but is actually a part of cloudData.swift
    This function displays an error if the user is not connected to the internet */
//    func errorUpdating(error: NSError) {
//        // Error Code 4 is Network Failure
//        if error.code == 4
//        {
//            let message = "You do not have internet access. Now Entering AirPlane Mode."
//            let alert = UIAlertView(title: "Error Loading Cloud Data.",
//                message: message, delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
//        }
//            // Error Code 9 is iCloud Not Setup
//        else if error.code == 9
//        {
//            let message = "Please go to iPhone Settings->iCloud and sign in."
//            let alert = UIAlertView(title: "This App Requires iCloud",
//                message: message, delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
//        }
//        
//        // Display Airplane Mode
////        activityIndicatorView.stopAnimating()
//        countLabel.text = "0"
//        self.startDate = NSDate()
//        let aSelector:Selector = "updateTime"
//        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
//        plusButton.enabled = true
        // set Airplane Mode
//        self.airplaneMode = true
        // self.view.backgroundColor = UIColor.blackColor()
//        self.tabBarController?.tabBar.userInteractionEnabled = false
        
//        return
//    }
    
    /* Delegate function is defined here but is actually declared in cloudData.swift
    This function updates the count with an NSDate argument in order to update the Timer */
//    func countUpdated(timeOfLastCig:NSDate) {
//        dailyCount.text = String(model.dailyRecords.count)
//        NSLog("Upon Load 'Today's Count' has been updated to: \(model.dailyRecords.count)")
//        activityIndicatorView.stopAnimating()
//        plusButton.enabled = true
//        self.tabBarController?.tabBar.userInteractionEnabled = true
        // initiate timer (Uses starDate from today if there is a record, else calls grabLastCig)
//        self.startDate = timeOfLastCig
        // listen for when the data comes back
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "grabLastCig", name: "fetchLastRecord", object: nil)
//        let aSelector:Selector = "updateTime"
//        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        // refresh Today Widget values
//        let sharedDefaults = NSUserDefaults(suiteName: "group.TrackerTeamA")
//        sharedDefaults?.setObject(model.dailyRecords.count, forKey: "count")
//        sharedDefaults?.synchronize()
//    }
    
    
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
