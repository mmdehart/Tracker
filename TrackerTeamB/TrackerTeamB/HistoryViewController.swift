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
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // get the mapdata
        let settings = appDelegate.getSetData()
        
        textLabel.text = "Today's Total"
        maxLabel.text = "\(settings.dailyMax)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // get the mapdata
        let settings = appDelegate.getSetData()
        switch segControl.selectedSegmentIndex {
        case 0:
            textLabel.text = "Today's Total"
            maxLabel.text = "\(settings.getDailyMax())"
        case 1:
            textLabel.text = "This Week's Total"
            maxLabel.text = "\(settings.getWeeklyMax())"
        case 2:
            textLabel.text = "This Month's Total"
            maxLabel.text = "\(settings.getMonthlyMax())"
        case 3:
            textLabel.text = "This Year's Total"
            maxLabel.text = "\(settings.getYearlyMax())"
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
