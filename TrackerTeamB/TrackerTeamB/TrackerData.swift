//
//  TrackerData.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/20/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import Foundation

class TrackerData : NSObject {
    var cig:NSDate?
    init(cig:NSDate) {
        self.cig = cig
    }
    
    func cigDate() -> NSDate {
        return cig!
    }
    
    //var cigarettes = [NSDate]
    //var cigarettes = NSMutableArray()
    //var cig:NSDate = NSDate()
    
}
