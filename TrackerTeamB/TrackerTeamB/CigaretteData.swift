//
//  CigaretteData.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 12/2/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import Foundation
import UIKit

class CigaretteData : NSObject {
    var cigDate : NSDate?
    
    init(cig:NSDate) {
        self.cigDate = cig
    }
    
    func getCigDate() ->NSDate {
        return cigDate!
    }
    
//    
//    func getDailyCount() -> Int {
//        
//    }
//    
//    func getWeeklyCount() -> Int {
//        
//    }
//    
//    
//    func getMonthlyCount() ->Int {
//        
//    }
//    
//    func getYearlyCount() -> Int {
//        
//    }
}
