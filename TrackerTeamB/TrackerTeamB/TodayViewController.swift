//
//  TodayViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!

    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var dateSinceLast: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let testDatabase = appDelegate.getTestDatabase()
        
        //This will show the current date when opening the application (JK)
        var todaysDate = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        date.text = "\(todaysDate)"
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        // This allows the "database" which is a dictionary right now, to be able to be accessed
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let testDatabase = appDelegate.getTestDatabase()
        
        countLabel.text = Int(sender.value).description
        //Here is where we will add the timeStamp into the "Database"
        testDatabase.addTimeStamp(0, timeStamp: NSDate())
        //The "testDatabase.dataBase[0] is how to access the first key in the database. Think of it as the primary key being accessed
        var lastDate = NSDateFormatter.localizedStringFromDate((testDatabase.dataBase[0]!), dateStyle: .ShortStyle, timeStyle: .LongStyle)
        //need to figure out how to format the output to show what we need to see... Month: Hour: Minute: Second:
        dateSinceLast.text = "\(lastDate)"
        
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
