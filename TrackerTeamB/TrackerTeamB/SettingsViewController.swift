//
//  SettingsViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/11/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    @IBOutlet weak var maxNumber: UILabel!
    @IBOutlet weak var maxSlider: UISlider!
    @IBOutlet weak var weeklyEst: UILabel!
    @IBOutlet weak var yearlyEst: UILabel!
    @IBOutlet weak var monthlyEst: UILabel!
    
    var coreDataStack : CoreDataStack!
    
    var fetchRequest : NSFetchRequest!
    var setVal: Settings!
    
//    var appDelegate:AppDelegate!
//    var settings:SettingsData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let settingEntity = NSEntityDescription.entityForName("Settings", inManagedObjectContext: coreDataStack.context)
        let setting = Settings(entity: settingEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        fetchRequest = NSFetchRequest(entityName: "Settings")
        
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
                maxSlider.value = Float(setVal.dailyMax)
                maxNumber.text = "\(setVal.dailyMax)"
                weeklyEst.text = "\(Int(setVal.dailyMax) * 7) cigarettes"
                monthlyEst.text = "\(Int(setVal.dailyMax) * 30) cigarettes"
                yearlyEst.text = "\(Int(setVal.dailyMax) * 365) cigarettes"
            }
        } else {
            println("Could not fetch: \(error)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberChanged(sender: UISlider) {
        var intValue:Int = Int(maxSlider.value)
        maxNumber.text = "\(intValue)"
        weeklyEst.text = "\(intValue*7) cigarettes"
        monthlyEst.text = "\(intValue*30) cigarettes"
        yearlyEst.text = "\(intValue*365) cigarettes"
        
    }

//    func fetchAndReload() {
//        var error:NSError?
//        var sets: [Settings]!
//        let results = coreDataStack.context.executeFetchRequest(fetchRequest, error: &error) as [Settings]?
////        results. ./setFetchLimit:1
//        if let fetchedResults = results {
//            sets = fetchedResults
//            
//        } else {
//            println("Could not fetch \(error), \(error!.userInfo)")
//        }
//        
//    }

    @IBAction func setValue(sender: UISlider) {
        coreDataStack.saveContext()
        println("save")
        
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
