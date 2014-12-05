//
//  TrackeriCloud.swift
//  TrackerTeamB
//
//  Created by Jonathan Kendrick on 12/2/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import CloudKit

protocol CloudKitDelegate {
    func errorUpdating(error:NSError)
    func countUpdated(timeOfLastCig:NSDate)
}

class cigData {
    var container: CKContainer
    let privateDB: CKDatabase
    var delegate: CloudKitDelegate?
    
    var logRecords = [grabbedRecord]()
    var lastRecords = [grabbedRecord]()
    
    init() {
        container = CKContainer.defaultContainer()
        privateDB = container.privateCloudDatabase
    }
    
    func save_Record() {
        let record = CKRecord(recordType: "TrackerData")
        var date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        var DateString:String = formatter.stringFromDate(date)
        var records_Loaded: Int = 0
        records_Loaded = logRecords.count
        record.setObject(date, forKey: "date")
        
        record.setValue(records_Loaded, forKey: "records_Loaded_at_start")
        
        self.privateDB.saveRecord(record, completionHandler: { (record, error) -> Void in
            NSLog("New Record has been saved")
        })
    }
    
    func update_records() {
        var date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        var queryDate:String = formatter.stringFromDate(date)
        let predicate = NSPredicate(format: "date==%@", queryDate)
        let sort = NSSortDescriptor(key: "NSDate", ascending: true)
        
        let query = CKQuery(recordType: "Log", predicate: predicate)
        query.sortDescriptors = [sort]
        
        self.privateDB.performQuery(query, inZoneWithID: nil)
            {
                    results, error in
                if error != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.errorUpdating(error)
                        return
                    }
                } else {
                    NSLog("Fetching Data From Today")
                    var i = 0
                    for record in results {
                        let grabRecord = grabbedRecord(record: record as CKRecord, database: self.privateDB)
                        self.logRecords.append(grabRecord)
                        i++
                    }
                    var dateOfLastCig: NSDate = NSDate()
                    if (i==0) {
                        NSLog("No Records from Today, Fetching All Data")
                        self.grabLastCig()
                    }
                    else {
                        dateOfLastCig = self.logRecords[self.logRecords.count-1].cig
                    }
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        if let aDelegate = self.delegate {
                            aDelegate.countUpdated(dateOfLastCig)
                        }
                    })
                }
        }
    }
    
    func grabLastCig() {
        let predicate = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "NSDate", ascending: false)
        let query = CKQuery(recordType: "Log", predicate: predicate)
        query.sortDescriptors = [sort]
        
        let request = CKQueryOperation(query: query)
        request.resultsLimit = 1
        request.desiredKeys = ["NSDate"]
        var results = NSMutableArray()
        
        request.recordFetchedBlock = { (record: CKRecord!) in
            let grabRecord = grabbedRecord(record: record as CKRecord, database: self.privateDB)
            self.lastRecords.append(grabRecord)
            println("Result: \(self.lastRecords[0].cig)")
            results.addObject(record)
            NSNotificationCenter.defaultCenter().postNotificationName("fetchAllRecords", object: nil)
        }
        
        self.privateDB.addOperation(request)
        return
    }
}
