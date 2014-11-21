//
//  EditTableViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/20/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {

    @IBOutlet var tableThing: UITableView!
    //@IBOutlet weak var tableCell: UITableViewCell!
    
    //let tableData = ["Red", "Orange", "Yellow", "Green", "Blue", "Indigo", "Violet"]
    
    var detailItems: AnyObject? {
        didSet {
            self.configureView()
        }
    }
    
    func configureView() {
        if let objs: NSMutableArray = self.detailItems as? NSMutableArray {
            for var i = 0; i < objs.count; i++ {
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                self.tableThing.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
//        tableThing.delegate = self
//        tableThing.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return detailItems.count
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableThing.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
//        
//        let object = detailItems[indexPath.row] as NSDate
//        cell.textLabel.text = object.description
//        return cell
//    }
//    
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            objects.removeObjectAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }

    
    
    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
}
