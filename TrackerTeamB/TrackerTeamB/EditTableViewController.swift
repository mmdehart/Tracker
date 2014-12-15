//
//  EditTableViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/20/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

class EditTableViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableThing: UITableView!

    var data : [NSDate]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let cigs = defaults.arrayForKey("cigLog") as [NSDate]? {
            data = defaults.arrayForKey("cigLog") as [NSDate]
        }
        
        data.sort({ $0.compare($1) == NSComparisonResult.OrderedDescending })
        
        // Do any additional setup after loading the view.
    }
    
    
     func tableView(tableThing: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    
     func tableView(tableThing: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableThing.dequeueReusableCellWithIdentifier("cell", forIndexPath:indexPath) as UITableViewCell
        
        
        var timeFormatter: NSDateFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let anItem = data[indexPath.row] as NSDate
        
        
        var TimeString:String = timeFormatter.stringFromDate(anItem)
        var date:String = dateFormatter.stringFromDate(anItem)
        
        cell.textLabel?.text = "Cigarette"
        cell.detailTextLabel?.text = "Smoked at \(TimeString) on \(date)"
        
        return cell
    }
    
     func tableView(tableThing: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
     func tableView(tableThing: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let anItem = data[indexPath.row] as NSDate
        
        var recordToRemove = anItem
        
        data.removeAtIndex(indexPath.row)
        data.sort({ $0.compare($1) == NSComparisonResult.OrderedDescending })
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(data, forKey: "cigLog")
        defaults.synchronize()
        
        tableThing.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    


}
