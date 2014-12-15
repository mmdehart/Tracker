//
//  sesRec.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 12/10/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

class sessionRecord: NSObject, NSCoding {
    var date_NS : NSDate!
    var dateString: String!
    
    // Decode
    required init(coder aDecoder: NSCoder)
    {
        self.date_NS = aDecoder.decodeObjectForKey("date") as NSDate?
    }
    // No decoding needed
    override init()
    {
        self.date_NS = NSDate()
    }
    // Encode
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.date_NS, forKey: "date")
    }
}