//
//  CigaretteLog.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 12/12/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import Foundation
import CoreData

class CigaretteLog: NSManagedObject {

    @NSManaged var cigDate: NSDate
 
    class func createInManagedObjectContext(moc: NSManagedObjectContext, date: NSDate) -> CigaretteLog {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("CigaretteLog", inManagedObjectContext: moc) as CigaretteLog
        newItem.cigDate = date
        
        return newItem
    }

}