//
//  TodayViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import Foundation
import CloudKit


class TodayViewController: UIViewController, CloudKitDelegate {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var timeSince: UILabel!
    
    var model: cigData!
    
    
   // var cigarettes:[trackerData] = []
    
    let dateFormatter = NSDateFormatter()
    //let timeFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = NSDate()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        model = appDelegate.getCigData()
        model.delegate = self
   //     model.update_Records()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        //timeFormatter.timeStyle =
        todayDate.text = dateFormatter.stringFromDate(today)

        countLabel.text = "\(0)"
        //let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        //let data = appDelegate.getTrackerData()
        
        timeSince.text = "0"
        model.update_records()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func plusButtonPressed(sender: UIButton) {
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        model.save_Record()
        
        // timeSince.text = dateFormatter.stringFromDate(model.logRecords[0].cig)
            
        
        
        
      /* if cigarettes.count != 0 {
            var lastdate:NSDate! = self.cigarettes.last?.cig
            var timesince = NSDate().timeIntervalSinceDate(lastdate)
            timeSince.text = "\(timesince)"
        }
        
        self.cigarettes.append(trackerData(cig: NSDate()))
        countLabel.text = "\(self.cigarettes.count)"
        //let now = NSDate()

    */
        
        
    }
    
    func errorUpdating(error: NSError) {
        let message = error.localizedDescription
        let alert = UIAlertView(title: "Error Loading Cloud Data. Please Check your Internet Connection",
            message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    func countUpdated(timeOfLastCig: NSDate) {
        countLabel.text = String(model.logRecords.count)
        NSLog("Upon Load the 'Count' has been updated to: \(model.logRecords.count)")
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
