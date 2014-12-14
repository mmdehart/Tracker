//
//  allRec.swift
//  TrackerTeamB
//
<<<<<<< HEAD
//  Created by Madison DeHart on 12/8/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//


=======
//  Created by Madison DeHart on 12/10/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

>>>>>>> fcf2ac09a5ca581c9efedd09bfacc3c157e7ab08
import Foundation
import CloudKit

class allRec: NSObject {
    
    var record : CKRecord!
<<<<<<< HEAD
    var dateString : String!
    var date_NS : NSDate!
    var month : String!
    var year : String!
=======
    var fullDate : NSDate!
    var day : NSInteger!
    var month : NSInteger!
    var year : NSInteger!
    
>>>>>>> fcf2ac09a5ca581c9efedd09bfacc3c157e7ab08
    weak var database : CKDatabase!
    
    init(record : CKRecord, database: CKDatabase)
    {
        self.record = record
        self.database = database
<<<<<<< HEAD
        self.dateString = record.objectForKey("date") as String!
        self.date_NS = record.objectForKey("NSDate") as NSDate!
        self.month = record.objectForKey("month") as String!
        self.year = record.objectForKey("year") as String!
    }
    
}
=======
        self.fullDate = record.objectForKey("fullDate") as NSDate!
        self.day = record.objectForKey("day") as NSInteger!
        self.month = record.objectForKey("month") as NSInteger!
        self.year = record.objectForKey("year") as NSInteger!
    }

}
>>>>>>> fcf2ac09a5ca581c9efedd09bfacc3c157e7ab08
