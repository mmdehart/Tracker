//
//  recordGrabbed.swift
//  TrackerTeamB
//
//  Created by Jonathan Kendrick on 12/4/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import Foundation
import CloudKit

class grabbedRecord: NSObject {
    var record: CKRecord!
    var cig: NSDate!
    weak var database: CKDatabase!
    
    init(record: CKRecord, database: CKDatabase) {
        self.record = record
        self.database = database
        self.cig = record.objectForKey("NSDate") as NSDate!
    }
    var testDate = NSDate()
    
}
