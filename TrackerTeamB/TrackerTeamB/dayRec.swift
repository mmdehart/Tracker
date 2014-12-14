//
//  dayRec.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 12/10/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import Foundation
import CloudKit

class dayRec: NSObject
{
    var record : CKRecord!
    var fullDate : NSDate!
    var day : Int!
    var month : Int!
    var year : Int!
    
    weak var database : CKDatabase!
    
    init(record : CKRecord, database: CKDatabase)
    {
        self.record = record
        self.database = database
        self.fullDate = record.objectForKey("fullDate") as NSDate!
        self.day = record.objectForKey("day") as Int!
        self.month = record.objectForKey("month") as Int!
        self.year = record.objectForKey("year") as Int!
    }
}