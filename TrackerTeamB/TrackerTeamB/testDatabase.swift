//
//  testDatabase.swift
//  TrackerTeamB
//
//  Created by Jonathan Kendrick on 11/18/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

class TestDatabase: NSObject {
    
    var dataBase = [Int: NSDate]()
    
    internal func addTimeStamp(ID: Int, timeStamp: NSDate) {
        dataBase[ID] = timeStamp
    }
   
}
