//
//  TodayViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import Foundation

class TodayViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var timeSince: UILabel!
    
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
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func plusButtonPressed(sender: UIButton) {
        
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
