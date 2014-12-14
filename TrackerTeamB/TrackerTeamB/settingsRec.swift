//
//  settingsRec.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 12/10/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

class settingsRec: NSObject {
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    settingsRec = appDelegate.getCloudData()
    
    // grab total
    todaysCount = historyCloudData.LogRecords.count
    //println("(historyCloudData.LogRecords.count)")
    
    for count in historyCloudData.LogRecords[] {
    
    }
    
    // how to grab from LogRecords Array (date_NS "types" are declared in grabbedRecord.swift)
    // historyData.LogRecords[0].date_NS)
    // historyData.LogRecords[0].dateString)
    
    
}