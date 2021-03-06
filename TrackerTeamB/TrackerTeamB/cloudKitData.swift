//
//  cloudKitData.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 12/8/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import CloudKit

protocol CloudKitDelegate {
    func errorUpdating(error:NSError)
    func countUpdated(lastCig:NSDate)
}

//class


class cloudKitData
{
    var container: CKContainer
    let privateDB: CKDatabase
    var delegate: CloudKitDelegate?
    var dailyRecords = [dailyRec]()
    var lastRecord = [dailyRec]()
    var monthlyRecords = [monthlyRec]()
    
<<<<<<< HEAD
    // Current session records
    var sessionRecords = [sessionRec]()
    // AirplaneMode records
    var apModeRecords = [sessionRec]()
    var apModeRecord : sessionRec?
    var apModeDates = [NSDate]()
    // All Records
    var allRecords = [allRec]()
    // Goal (record)
    var goalRecord: CKRecord!
    var maxGoal: Int = 0
=======
    var testrecords = [dayRec]()
    
    var todayCount:Int = 0
    
    var apModeDates = [NSDate]()
>>>>>>> maybe
    
    init(){
        container = CKContainer.defaultContainer()
        privateDB = container.privateCloudDatabase
    }
<<<<<<< HEAD
    
    func saveToPhone()
    {
        var now = NSDate()
        self.apModeDates.append(now)
        // let data : NSData = NSKeyedArchiver.archivedDataWithRootObject(self.airplaneModeDates)
        NSUserDefaults.standardUserDefaults().setObject(self.apModeDates, forKey: "records")
        println("Saving Record [\(now)]to Phone")
    }
    
    func saveToCloud(date: NSDate)
    {
        // Save to current session's records array
        let today = sessionRec()
        self.sessionRecords.append(today)
=======

    func saveToPhone()
    {
        // var path: NSArray = NSSearchPathForDirectoriesInDomains(NSD, NSUserDefaults, YES)
        // var directory: NSString = path.objectAtIndex(0)
        // var success = false
        // Save to airplaneMode records array
        /*
        if let today = airplaneModeRecord{
        success = NSKeyedArchiver.archiveRootObject(today, toFile: "record.plist")
        if success
        {
        println("Saved Successfully")
        }
        else
        {
        println("Error saving data file")
        }
        }
        */
        // let today = sessionRecord()
        // self.airplaneModeRecords.append(today)
        // NSKeyedArchiver.archiveRootObject(airplaneModeRecords, toFile: "records")
        /*
        for dates in airplaneModeDates{
        println("\(self.airplaneModeDates[airplaneModeDates.count-1])")
        }
        */
        self.apModeDates.append(NSDate())
        // let data : NSData = NSKeyedArchiver.archivedDataWithRootObject(self.airplaneModeDates)
        NSUserDefaults.standardUserDefaults().setObject(self.apModeDates, forKey: "records")
        println("Saving Record [\(NSDate())]to Phone")
    }
    
    func saveToCloud(date: NSDate)
    {
        // Save to current session's records array
//        let today = sessionRecord()
//        self.sessionRecords.append(today)
>>>>>>> maybe
        
        // Object that decides which Record (or Table) to save to.
        let record = CKRecord(recordType: "Log")
        
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        
<<<<<<< HEAD
        let dateComp:NSDateComponents = calendar.components(flags, fromDate: date)
        
//        var records_loaded: Int = 0
        var records_loaded = dailyRecords.count
        record.setObject(date, forKey: "fullDate")

        record.setObject(dateComp.day as NSNumber, forKey: "day")
        
        //Append Month and Year info to insert query
        record.setObject(dateComp.month as NSNumber, forKey: "month")
        record.setObject(dateComp.year as NSNumber, forKey: "year")
=======
        let thisComps:NSDateComponents = calendar.components(flags, fromDate: date)
        
        var fullDate:NSDate = date
        var day:Int = thisComps.day
        var month:Int = thisComps.month
        var year:Int = thisComps.year
        
//        var formatter = NSDateFormatter()
//        // Format the day and time into string.
//        formatter.dateFormat = "MM-dd-yyyy"
//        var DateString:String = formatter.stringFromDate(date)
//        
//        //format the month and year variables
//        formatter.dateFormat = "MM"
//        var month:String = formatter.stringFromDate(date)
//        
//        formatter.dateFormat = "yyyy"
//        var year:String = formatter.stringFromDate(date)
        
        var records_loaded: Int = 0
        records_loaded = testrecords.count
        
        record.setObject(fullDate, forKey: "fullDate")
        record.setObject(day, forKey: "day")
        record.setObject(month, forKey: "month")
        record.setObject(year, forKey: "year")
//        records_loaded = dailyRecords.count
        // Append Information to the insert query
        // These fields will be used for query purposes
//        record.setObject(DateString, forKey: "date")
        // record.setObject(TimeString, forKey: "time")
        // This field will be used for grabbing new data when the user is in the app. (Because we will already have some records upon Load)
        // record.setValue(records_loaded, forKey: "records_loaded_at_start")
        // This field will be used for dealing with NSDate and NSTimer.
//        record.setObject(date, forKey: "NSDate")
        
        //Append Month and Year info to insert query
//        record.setObject(month, forKey: "month")
//        record.setObject(year, forKey: "year")
>>>>>>> maybe
        
        // Save record is the function used similar to Insert Statement in RDBMS
        self.privateDB.saveRecord(record, completionHandler: { (record, error) -> Void in
            NSLog("New Record has been Saved to cloud kit")
        })
<<<<<<< HEAD
    }
    
    /* This function grabs today's records based on date */
    func grabToday()
=======
        todayCount = testrecords.count
        NSLog("\(todayCount)")
    }
    
//     This function grabs today's records based on date 
    func getTodayRecs()
    {
        // Predicate is the condition on which the record should be matched against
        // First, Grab the current date, then format the date.
        var date = NSDate()
//        var formatter = NSDateFormatter()
//        formatter.dateFormat = "MM-dd-yyyy"
        
//        var queryDate:String = formatter.stringFromDate(date)
        
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        
        let thisComps:NSDateComponents = calendar.components(flags, fromDate: date)
        
        var fullDate:NSDate = date
        var day:Int = thisComps.day
        var month:Int = thisComps.month
        var year:Int = thisComps.year
        
        
//        let predicate = NSPredicate(format: "(day = %@) AND (month = %@) AND (year = %@)", day, month, year)
        let predicate = NSPredicate(format: "month==%i", month)
//        let yearpredicate = NSPredicate(format: "year==%@", year)
        let sort = NSSortDescriptor(key: "NSDate", ascending: true)
        // Build the Query: This query is similar to SELECT * FROM Log WHERE date = ''
        let query = CKQuery(recordType: "Log", predicate: predicate)
        
        // Select all records
        // let query = CKQuery(recordType: "Log", predicate: true)
        
        query.sortDescriptors = [sort]
        // Execute the Query
        self.privateDB.performQuery(query,inZoneWithID: nil)
            {
                results, error in
                // If we have an error than display it
                if error != nil
                {
                    dispatch_async(dispatch_get_main_queue())
                        {
                            self.delegate?.errorUpdating(error)
                            return
                    }
                }
                    // Fetch todays data
                else
                {
                    NSLog("Fetching Data From Today")
                    var i = 0
                    // Records returned
                    for record in results
                    {
                        // Initialize multiple dailyRecord Objects
                        let grabRecord = dayRec(record: record as CKRecord, database: self.privateDB)
                        // Append the record to LogRecords Object which is local to this class.
                        self.testrecords.append(grabRecord)
                        i++
                    }
                    // Find Date of Last Cigarette
                    var dateOfLastCig:NSDate = NSDate()
                    // If no records from today, then grab the last cigarette from a different day (Not Today)
                    if (i==0)
                    {
                        NSLog("No Records from Today, Fetching All Data")
//                        self.grabLastCig()
                    }
                        // else use the last cigarette from Today.
                    else
                    {
                        dateOfLastCig = self.testrecords[self.testrecords.count-1].fullDate
                    }
                    
                    // Tell the ViewController that the Data has returned and update the "Count" in the View.
                    // Run countUpdated() on the main thread, because that is the only thread that allows the Interface to be updated.
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        // Forces an optional to non optional (Runs only if the optional is not nil)
                        if let aDelegate = self.delegate {
                            aDelegate.countUpdated(dateOfLastCig)
                        }
                    })
                    
                    /*
                    if let localRecord = NSKeyedUnarchiver.unarchiveObjectWithFile("records") as sessionRecord?
                    {
                    println("Local Records: \(localRecord.date_NS)")
                    }
                    */
                    // Unarchive + Load any records if user incremented during Airplane Mode or using the Widget.
//                    if let savedDates = NSUserDefaults.standardUserDefaults().objectForKey("records") as? [NSDate] {
//                        println("There are some Records saved on the phone. Now Uploading them to iCloud...")
//                        // airplaneModeDates can be used in other ViewControllers if someone needs them.
//                        self.airplaneModeDates = savedDates
//                        // Save All the Records to the Cloud
//                        for records in self.airplaneModeDates{
//                            self.save_record_to_cloud(records)
//                            println(records)
//                        }
//                        println("Those Records have been sent to iCloud. Now Clearing local records.")
//                        // Clear out the local data from NSUserDefaults
//                        var appDomain = NSBundle.mainBundle().bundleIdentifier
//                        // NSUserDefaults.removePersistentDomainForName(appDomain)
//                        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
//                    }
                }
        }
    }
    
    /* Function to grab the current month's records */
    /*func grab_months_records() {
    //Make Query to get the records of the current month
    // Predicate is the condition on which the record should be matched against
    // First, Grab the current month, then format the month.
    var date = NSDate()
    var formatter = NSDateFormatter()
    formatter.dateFormat = "MM"
    var queryMonth:String = formatter.stringFromDate(date)
    
    let predicate = NSPredicate(format: "month==%@", queryMonth)
    let sort = NSSortDescriptor(key: "NSDate", ascending: true)
    
    // Build the Query: This query is similar to SELECT * FROM Log WHERE month = ''
    let query = CKQuery(recordType: "Log", predicate: predicate)
    
    query.sortDescriptors = [sort]
    // Execute the Query
    self.privateDB.performQuery(query,inZoneWithID: nil)
    {
    results, error in
    // If we have an error, display it
    if error != nil
    {
    dispatch_async(dispatch_get_main_queue())
>>>>>>> maybe
    {
        // Predicate is the condition on which the record should be matched against
        // First, Grab the current date, then format the date.
        var today = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let flags:NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        
//        var queryDate:String = formatter.stringFromDate(date)
        let queryDate:NSDateComponents = calendar.components(flags, fromDate: today)
        
        let predicate = NSPredicate(format: "day==%@ AND month==%@ AND year==%@", queryDate.day as NSNumber, queryDate.month as NSNumber, queryDate.year as NSNumber)
        let sort = NSSortDescriptor(key: "fullDate", ascending: true)
        // Build the Query: This query is similar to SELECT * FROM Log WHERE date = ''
        let query = CKQuery(recordType: "Log", predicate: predicate)
        
        // Select all records
        // let query = CKQuery(recordType: "Log", predicate: true)
        
        query.sortDescriptors = [sort]
        // Execute the Query
        self.privateDB.performQuery(query,inZoneWithID: nil)
            {
                results, error in
                // If we have an error than display it
                if error != nil
                {
                    dispatch_async(dispatch_get_main_queue())
                    {
                            self.delegate?.errorUpdating(error)
                            return
                    }
                }
                    // Fetch todays data
                else
                {
                    NSLog("Fetching Data From Today")
                    var i = 0
                    // Records returned
                    for record in results
                    {
                        // Initialize multiple dailyRecord Objects
                        let grabRecord = dailyRec(record: record as CKRecord, database: self.privateDB)
                        // Append the record to LogRecords Object which is local to this class.
                        self.dailyRecords.append(grabRecord)
                        i++
                    }
                    // Find Date of Last Cigarette
                    var dateOfLastCig:NSDate = NSDate()
                    // If no records from today, then grab the last cigarette from a different day (Not Today)
                    if (i==0)
                    {
                        NSLog("No Records from Today, Fetching All Data")
                        self.grabLastCig()
                    }
                        // else use the last cigarette from Today.
                    else
                    {
                        dateOfLastCig = self.dailyRecords[self.dailyRecords.count-1].date_NS
                    }
                    
                    // Tell the ViewController that the Data has returned and update the "Count" in the View.
                    // Run countUpdated() on the main thread, because that is the only thread that allows the Interface to be updated.
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        // Forces an optional to non optional (Runs only if the optional is not nil)
                        if let aDelegate = self.delegate {
                            aDelegate.countUpdated(dateOfLastCig)
                        }
                    })
                    
                                        // Unarchive + Load any records if user incremented during Airplane Mode or using the Widget.
                    if let savedDates = NSUserDefaults.standardUserDefaults().objectForKey("records") as? [NSDate] {
                        println("There are some Records saved on the phone. Now Uploading them to iCloud...")
                        // airplaneModeDates can be used in other ViewControllers if someone needs them.
                        self.apModeDates = savedDates
                        // Save All the Records to the Cloud
                        for records in self.apModeDates{
                            self.saveToCloud(records)
                            println(records)
                        }
                        println("Those Records have been sent to iCloud. Now Clearing local records.")
                        // Clear out the local data from NSUserDefaults
                        var appDomain = NSBundle.mainBundle().bundleIdentifier
                        // NSUserDefaults.removePersistentDomainForName(appDomain)
                        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
                    }
                }
        }
    }
    
    
    
    /* Function to grab the last record if there are no records for the current day */
    func grabLastCig()
    {
        let predicate = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "fullDate", ascending: false)
        let query = CKQuery(recordType: "Log", predicate: predicate)
        query.sortDescriptors = [sort]
        
        let request = CKQueryOperation(query: query)
        request.resultsLimit = 1
        request.desiredKeys = ["fullDate"]
        var results = NSMutableArray()
        
        request.recordFetchedBlock = { (record: CKRecord!) in
            let grabRecord = dailyRec(record: record as CKRecord, database: self.privateDB)
            self.lastRecord.append(grabRecord)
            println("Last Cigarette was: \(self.lastRecord[0].date_NS)")
            results.addObject(record)
            NSNotificationCenter.defaultCenter().postNotificationName("fetchLastRecord", object: nil)
        }
        
        self.privateDB.addOperation(request)
        return
    }
    
<<<<<<< HEAD
=======
    
    /* Function to grab the current year's records */
    func years_records() {
    //Query to get the records of the current month
    
    }*/
    
    
    /* Function to grab the last record if there are no records for the current day */
    func grabLastCig()
    {
        let predicate = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "NSDate", ascending: false)
        let query = CKQuery(recordType: "Log", predicate: predicate)
        query.sortDescriptors = [sort]
        
        let request = CKQueryOperation(query: query)
        request.resultsLimit = 1
        request.desiredKeys = ["NSDate"]
        var results = NSMutableArray()
        
        request.recordFetchedBlock = { (record: CKRecord!) in
            let grabRecord = dayRec(record: record as CKRecord, database: self.privateDB)
            self.testrecords.append(grabRecord)
            println("Last Cigarette was: \(self.testrecords[0].fullDate)")
            results.addObject(record)
            NSNotificationCenter.defaultCenter().postNotificationName("fetchLastRecord", object: nil)
        }
        
        self.privateDB.addOperation(request)
        return
    }
    
>>>>>>> maybe
    // Function to tell grabGoal wether or not to Save
    func saveGoal(var goal: Int){
        grabGoal(true, newGoal: goal)
    }
    
    func saveNewGoal(newGoal: Int) {
        let record_id:CKRecordID = CKRecordID(recordName: "1")
        var record2: CKRecord!
        record2 = CKRecord(recordType: "Settings", recordID: record_id)
        record2.setObject(newGoal, forKey: "dailyMax")
        
        self.privateDB.saveRecord(record2, completionHandler: { record, error in
            if error != nil {
                println("Error occurred while saving \(error)")
            }
            else
            {
                NSLog("Saving Goal to iCloud As: \(newGoal)")
                self.maxGoal = newGoal
            }
        })
        
    }
    
    // Function to grab the goal from the cloud AND THEN SAVE IF NECCESSARY
    func grabGoal(save : BooleanType, newGoal: Int){
        let record_id:CKRecordID = CKRecordID(recordName: "1")
        var record: CKRecord!
        var error: NSError!
        privateDB.fetchRecordWithID(record_id){
            (dbRecord, error) in
            if error != nil
            {
                println("Error Grabbing Goal from iCloud \(error)")
                println(save)
                println("\(newGoal)")
                if (save) {
                    self.saveNewGoal(newGoal)
                }
                
            }
            else
            {
                // Push this block to main thread
                dispatch_async(dispatch_get_main_queue())
                    {
                        // Save the Goal (Integer) to maxGoal
                        self.maxGoal = dbRecord.objectForKey("dailyMax") as Int!
                        // If user wants to save, then push to Cloud, else don't push to Cloud
                        if (save)
                        {
                            dbRecord.setObject(newGoal, forKey: "dailyMax")
                            self.privateDB.saveRecord(dbRecord, completionHandler: { record, error in
                                if error != nil {
                                    println("Error occurred while saving \(error)")
                                }
                                else
                                {
                                    NSLog("Saving Goal to iCloud As: \(newGoal)")
                                    self.maxGoal = newGoal
                                }
                                
                            })
                        }
                        else
                        {
                            // Post to Notification Center to let GoalsTab Know When Done
                            NSNotificationCenter.defaultCenter().postNotificationName("fetchGoal", object: nil)
                        }
                }
            }
        }
        return
    }
<<<<<<< HEAD
    
    func grabAllRecords() {
        // First, Grab the current date, then format the date.
        var date = NSDate()
        
        let predicate = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "fullDate", ascending: true)
        // Build the Query: This query is similar to SELECT * FROM Log WHERE date = ''
        let query = CKQuery(recordType: "Log", predicate: predicate)
        
        query.sortDescriptors = [sort]
        // Execute the Query
        self.privateDB.performQuery(query,inZoneWithID: nil)
            {
                results, error in
                // If we have an error than display it
                if error != nil
                {
                    dispatch_async(dispatch_get_main_queue())
                        {
                            self.delegate?.errorUpdating(error)
                            return
                    }
                    
                }
                    // Fetch todays data
                else
                {
                    NSLog("Fetching All Data")
                    var i = 0
                    // Records returned
                    for record in results
                    {
                        // Initialize multiple allRecord Objects
                        let aRecord = allRec(record: record as CKRecord, database: self.privateDB)
                        // Append the record to LogRecords Object which is local to this class.
                        self.allRecords.append(aRecord)
                        i++
                    }
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("fetchAllRecords", object: nil)
                }
                
        }
        
    }
=======

//    func grabAllRecords() {
//        // First, Grab the current date, then format the date.
//        var date = NSDate()
//        var formatter = NSDateFormatter()
//        formatter.dateFormat = "MM-dd-yyyy"
//        var queryDate:String = formatter.stringFromDate(date)
//        let predicate = NSPredicate(value: true)
//        let sort = NSSortDescriptor(key: "NSDate", ascending: true)
//        // Build the Query: This query is similar to SELECT * FROM Log WHERE date = ''
//        let query = CKQuery(recordType: "Log", predicate: predicate)
//        
//        query.sortDescriptors = [sort]
//        // Execute the Query
//        self.privateDB.performQuery(query,inZoneWithID: nil)
//            {
//                results, error in
//                // If we have an error than display it
//                if error != nil
//                {
//                    dispatch_async(dispatch_get_main_queue())
//                        {
//                            self.delegate?.errorUpdating(error)
//                            return
//                    }
//                    
//                }
//                    // Fetch todays data
//                else
//                {
//                    NSLog("Fetching All Data")
//                    var i = 0
//                    // Records returned
//                    for record in results
//                    {
//                        // Initialize multiple allRecord Objects
//                        let aRecord = allRecord(record: record as CKRecord, database: self.privateDB)
//                        // Append the record to LogRecords Object which is local to this class.
//                        self.allRecords.append(aRecord)
//                        i++
//                    }
//                    
//                    NSNotificationCenter.defaultCenter().postNotificationName("fetchAllRecords", object: nil)
//                }
//                
//        }
//        
//    }
>>>>>>> maybe
    
}