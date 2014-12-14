//
//  HistoryViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

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
    var appDelegate:AppDelegate!
    var model : cloudKitData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        model = appDelegate.getCloudData()
        textLabel.text = "Today's Total"
        graphLabel.text = "Hourly"
        averageLabel.text = "Daily Average"
        maxLabel.text = "\(model.maxGoal)"

    }
    
    override func viewWillAppear(animated : Bool) {
        histCount.text = "\(model.dailyRecords.count + model.sessionRecords.count)"
        maxLabel.text = "\(model.maxGoal)"
        segControl.selectedSegmentIndex = 0
        model.grabAllRecords()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        model = appDelegate.getCloudData()
        
        switch segControl.selectedSegmentIndex {
        case 0:
            textLabel.text = "Today's Total"
            graphLabel.text = "Hourly"
            averageLabel.text = "Daily Average"
            recordHigh.text = "\(appDelegate.getTodayMax())"
            avgAmtLabel.text = "\(appDelegate.getTodayAverage())"
            recordLow.text = "\(appDelegate.getTodayLow())"
            maxLabel.text = "\(model.maxGoal)"
            histCount.text = "\(model.dailyRecords.count + model.sessionRecords.count)"

        case 1:
            textLabel.text = "This Week"
            graphLabel.text = "Daily"
            averageLabel.text = "Weekly Average"
            recordHigh.text = "\(appDelegate.getWeeklyMax())"
            avgAmtLabel.text = "\(appDelegate.getWeeklyAverage())"
            recordLow.text = "\(appDelegate.getWeeklyLow())"
            maxLabel.text = "\(model.maxGoal * 7)"


        case 2:
            textLabel.text = "This Month"
            graphLabel.text = "Weekly"
            averageLabel.text = "Monthly Average"
            recordHigh.text = "\(appDelegate.getMonthlyMax())"
            avgAmtLabel.text = "\(appDelegate.getMonthlyAverage())"
            recordLow.text = "\(appDelegate.getMonthlyLow())"
            maxLabel.text = "\(model.maxGoal * 30)"


        case 3:
            textLabel.text = "This Year"
            graphLabel.text = "Monthly"
            averageLabel.text = "Yearly Average"
            recordHigh.text = "\(appDelegate.getYearlyMax())"
            avgAmtLabel.text = "\(appDelegate.getYearlyAverage())"
            recordLow.text = "\(appDelegate.getYearlyLow())"
            maxLabel.text = "\(model.maxGoal * 365)"


        default:
            break;
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
