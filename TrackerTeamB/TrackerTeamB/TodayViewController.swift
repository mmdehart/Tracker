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
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var timeSince: UILabel!
    
    var cigarettes:[TrackerData] = []
    
    let dateFormatter = NSDateFormatter()
    //let timeFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = NSDate()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        //timeFormatter.timeStyle =
        todayDate.text = dateFormatter.stringFromDate(today)

        countLabel.text = "\(self.cigarettes.count)"
        //let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        //let data = appDelegate.getTrackerData()
        
        timeSince.text = "0"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func plusButtonPressed(sender: UIButton) {
        if cigarettes.count != 0 {
            var lastdate:NSDate! = self.cigarettes.last?.cigDate()
            var timesince = NSDate().timeIntervalSinceDate(lastdate)
            timeSince.text = "\(timesince)"
        }
        
        self.cigarettes.append(TrackerData(cig: NSDate()))
        countLabel.text = "\(self.cigarettes.count)"
        //let now = NSDate()
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        (segue.destinationViewController as EditTableViewController).detailItems = cigarettes
//        
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    

}
