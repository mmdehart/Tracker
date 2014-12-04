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
    
    var appDelegate:AppDelegate!
//    var cigarettes:[CigaretteData]!
    var settings:SettingsData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        settings = appDelegate.getSetData()
//        cigarettes = appDelegate.getCigData()
        
        textLabel.text = "Today's Total"
        maxLabel.text = "\(settings.dailyMax)"
        histCount.text = "\(appDelegate.getTodayCount())"
        // the above line should eventually be changed to the next line
        // histCount = "\(appDelegate.getTodayCount())"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        settings = appDelegate.getSetData()
//        cigarettes = appDelegate.getCigData()
        
        switch segControl.selectedSegmentIndex {
        case 0:
            textLabel.text = "Today's Total"
            maxLabel.text = "\(settings.getDailyMax())"
            histCount.text = "\(appDelegate.getTodayCount())"
            // the above line should eventually be changed to the next line
            // histCount = "\(appDelegate.getTodayCount())"
        case 1:
            textLabel.text = "This Week"
            maxLabel.text = "\(settings.getWeeklyMax())"
//            histCount.text = "\(appDelegate.getTotalCigCount())"
            // the above line should eventually be changed to the next line
             histCount.text = "\(appDelegate.getWeekCount())"
        case 2:
            textLabel.text = "This Month"
            maxLabel.text = "\(settings.getMonthlyMax())"
//            histCount.text = "\(appDelegate.getTotalCigCount())"
            // the above line should eventually be changed to the next line
             histCount.text = "\(appDelegate.getMonthCount())"
        case 3:
            textLabel.text = "This Year"
            maxLabel.text = "\(settings.getYearlyMax())"
//            histCount.text = "\(appDelegate.getTotalCigCount())"
            // the above line should eventually be changed to the next line
             histCount.text = "\(appDelegate.getYearCount())"
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
