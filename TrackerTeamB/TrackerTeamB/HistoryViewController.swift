//
//  HistoryViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import CoreData

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
    
    var coreDataStack : CoreDataStack!
    
    var setVal : Settings!
    var fetchRequest : NSFetchRequest!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let settingEntity = NSEntityDescription.entityForName("Settings", inManagedObjectContext : coreDataStack.context)
        let setting = Settings(entity: settingEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        fetchRequest = NSFetchRequest(entityName : "Settings")
        
        var error: NSError?
        let result = coreDataStack.context.executeFetchRequest(fetchRequest, error: &error) as [Settings]?
        
        if let sets = result {
            if sets.count == 0 {
                setVal = Settings(entity: settingEntity!, insertIntoManagedObjectContext: coreDataStack.context)
                setVal.dailyMax = 5
                
                if !coreDataStack.context.save(&error) {
                    println("Could not save: \(error)")
                }
            } else {
                setVal = sets[sets.count - 1]
                maxLabel.text = "\(setVal.dailyMax)"
            }
        } else {
            println("Could not fetch: \(error)")
        }
        
        textLabel.text = "Today's Total"
        graphLabel.text = "Hourly"
        averageLabel.text = "Hourly Average"

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let settingEntity = NSEntityDescription.entityForName("Settings", inManagedObjectContext : coreDataStack.context)
        let setting = Settings(entity: settingEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        fetchRequest = NSFetchRequest(entityName : "Settings")
        
        var error: NSError?
        let result = coreDataStack.context.executeFetchRequest(fetchRequest, error: &error) as [Settings]?
        
        if let sets = result {
            if sets.count == 0 {
                setVal = Settings(entity: settingEntity!, insertIntoManagedObjectContext: coreDataStack.context)
                setVal.dailyMax = 5
                
                if !coreDataStack.context.save(&error) {
                    println("Could not save: \(error)")
                }
            } else {
                setVal = sets[sets.count - 1]
                maxLabel.text = "\(setVal.dailyMax)"
            }
        } else {
            println("Could not fetch: \(error)")
        }
        
        textLabel.text = "Today's Total"
        graphLabel.text = "Hourly"
        averageLabel.text = "Hourly Average"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {

        
        switch segControl.selectedSegmentIndex {
        case 0:
            textLabel.text = "Today's Total"
            graphLabel.text = "Hourly"
            averageLabel.text = "Hourly Average"
            maxLabel.text = "\(setVal.dailyMax)"
//            maxLabel.text = "\(settings.getDailyMax())"
//            histCount.text = "\(appDelegate.getTodayCount())"
//            timeSpentLabel.text = "\(appDelegate.getDayTimeSpent()) minutes"
            
            //  FIX THE TIME SPENT SHIT!!!
            
            // the above line should eventually be changed to the next line
            // histCount = "\(appDelegate.getTodayCount())"
        case 1:
            textLabel.text = "This Week"
            graphLabel.text = "Daily"
            averageLabel.text = "Daily Average"
            maxLabel.text = "\(Int(setVal.dailyMax) * 7)"
//            maxLabel.text = "\(settings.getWeeklyMax())"
//            histCount.text = "\(appDelegate.getTotalCigCount())"
            // the above line should eventually be changed to the next line
//             histCount.text = "\(appDelegate.getWeekCount())"
//            timeSpentLabel.text = "\(appDelegate.getWeekTimeSpent()) minutes"
            
            
            //  FIX THE TIME SPENT SHIT!!!
            
            
        case 2:
            textLabel.text = "This Month"
            graphLabel.text = "Weekly"
            averageLabel.text = "Weekly Average"
            maxLabel.text = "\(Int(setVal.dailyMax) * 30)"
//            maxLabel.text = "\(settings.getMonthlyMax())"
//            histCount.text = "\(appDelegate.getTotalCigCount())"
            // the above line should eventually be changed to the next line
//             histCount.text = "\(appDelegate.getMonthCount())"
//            timeSpentLabel.text = "\(appDelegate.getMonthTimeSpent()) minutes"
            

            //  FIX THE TIME SPENT SHIT!!!
            
        case 3:
            textLabel.text = "This Year"
            graphLabel.text = "Monthly"
            averageLabel.text = "Monthly Average"
            maxLabel.text = "\(Int(setVal.dailyMax) * 365)"
//            maxLabel.text = "\(settings.getYearlyMax())"
//            histCount.text = "\(appDelegate.getTotalCigCount())"
            // the above line should eventually be changed to the next line
//             histCount.text = "\(appDelegate.getYearCount())"
//            timeSpentLabel.text = "\(appDelegate.getYearTimeSpent()) minutes"
            

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
