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
//    var cigarettes:[CigaretteData]!
//    var settings:SettingsData!
    var model : cloudKitData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
//        settings = appDelegate.getSetData()
//        cigarettes = appDelegate.getCigData()
        model = appDelegate.getCloudData()
        textLabel.text = "Today's Total"
        graphLabel.text = "Hourly"
        averageLabel.text = "Daily Average"
        maxLabel.text = "\(model.maxGoal)"
        histCount.text = "\(model.testrecords.count)"
//        maxLabel.text = "\(settings.getDailyMax())"
//        histCount.text = "\(appDelegate.getTodayCount())"
//        timeSpentLabel.text = "\(model.testrecords.count+1) minutes"
        // the above line should eventually be changed to the next line
        // histCount = "\(appDelegate.getTodayCount())"
        
        //  FIX THE TIME SPENT SHIT!!!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        model = appDelegate.getCloudData()
//        settings = appDelegate.getSetData()
//        cigarettes = appDelegate.getCigData()
        
        switch segControl.selectedSegmentIndex {
        case 0:
            textLabel.text = "Today's Total"
            graphLabel.text = "Hourly"
            averageLabel.text = "Daily Average"
            maxLabel.text = "\(model.maxGoal)"
//            maxLabel.text = "\(settings.getDailyMax())"
//            histCount.text = "\(appDelegate.getTodayCount())"
//            timeSpentLabel.text = "\(appDelegate.getDayTimeSpent()) minutes"
            
            histCount.text = "\(model.testrecords.count)"
            //  FIX THE TIME SPENT SHIT!!!
            
            // the above line should eventually be changed to the next line
            // histCount = "\(appDelegate.getTodayCount())"
        case 1:
            textLabel.text = "This Week"
            graphLabel.text = "Daily"
            averageLabel.text = "Weekly Average"
            maxLabel.text = "\(model.maxGoal * 7)"
//            maxLabel.text = "\(settings.getWeeklyMax())"
//            histCount.text = "\(appDelegate.getTotalCigCount())"
            // the above line should eventually be changed to the next line
//             histCount.text = "\(appDelegate.getWeekCount())"
//            timeSpentLabel.text = "\(appDelegate.getWeekTimeSpent()) minutes"
            
            histCount.text = "\(model.testrecords.count)"
            
            //  FIX THE TIME SPENT SHIT!!!
            
            
        case 2:
            textLabel.text = "This Month"
            graphLabel.text = "Weekly"
            averageLabel.text = "Monthly Average"
            maxLabel.text = "\(model.maxGoal * 30)"
//            maxLabel.text = "\(settings.getMonthlyMax())"
//            histCount.text = "\(appDelegate.getTotalCigCount())"
            // the above line should eventually be changed to the next line
//             histCount.text = "\(appDelegate.getMonthCount())"
//            timeSpentLabel.text = "\(appDelegate.getMonthTimeSpent()) minutes"
            
            histCount.text = "\(model.testrecords.count)"

            //  FIX THE TIME SPENT SHIT!!!
            
        case 3:
            textLabel.text = "This Year"
            graphLabel.text = "Monthly"
            averageLabel.text = "Yearly Average"
            maxLabel.text = "\(model.maxGoal * 365)"
//            maxLabel.text = "\(settings.getYearlyMax())"
//            histCount.text = "\(appDelegate.getTotalCigCount())"
            // the above line should eventually be changed to the next line
//             histCount.text = "\(appDelegate.getYearCount())"
//            timeSpentLabel.text = "\(appDelegate.getYearTimeSpent()) minutes"
            
            histCount.text = "\(model.testrecords.count)"

            //  FIX THE TIME SPENT SHIT!!!
            
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
