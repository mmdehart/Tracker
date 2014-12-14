//
//  CigaretteLog.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 12/12/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

//import Foundation
//
//class CigaretteLog: NSObject, NSCoding {
//
//    var cigDate: NSDate!
// 
////    class func createInManagedObjectContext(moc: NSManagedObjectContext, date: NSDate) -> CigaretteLog {
////        let newItem = NSEntityDescription.insertNewObjectForEntityForName("CigaretteLog", inManagedObjectContext: moc) as CigaretteLog
////        newItem.cigDate = date
////        
////        return newItem
////    }
//    
//    override init() {
//        self.cigDate = NSDate()
//    }
//    
//    required init(coder aDecoder : NSCoder) {
//        self.cigDate = aDecoder.decodeObjectForKey("cigDate") as NSDate?
//    }
//    
//    func encodeWithCoder(coder : NSCoder) {
//        coder.encodeObject(self.cigDate, forKey: "cigDate")
//    }
//    
//
//}