//
//  allRec.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 12/10/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import Foundation
import CloudKit

class allRec: NSObject {
    
    var record : CKRecord!
    var fullDate : NSDate!
    var day : NSInteger!
    var month : NSInteger!
    var year : NSInteger!
    
    weak var database : CKDatabase!
    
    init(record : CKRecord, database: CKDatabase)
    {
        self.record = record
        self.database = database
        self.fullDate = record.objectForKey("fullDate") as NSDate!
        self.day = record.objectForKey("day") as NSInteger!
        self.month = record.objectForKey("month") as NSInteger!
        self.year = record.objectForKey("year") as NSInteger!
    }

}