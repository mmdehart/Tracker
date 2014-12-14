//
//  SettingsViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/11/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var maxNumber: UILabel!
    @IBOutlet weak var maxSlider: UISlider!
    @IBOutlet weak var weeklyEst: UILabel!
    @IBOutlet weak var yearlyEst: UILabel!
    @IBOutlet weak var monthlyEst: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let settings = defaults.integerForKey("dailyMax") as Int? {
            let num = defaults.integerForKey("dailyMax")
            self.maxNumber.text = "\(num)"
            self.maxSlider.value = Float(num)
            self.weeklyEst.text = "\(num * 7) cigarettes"
            self.monthlyEst.text = "\(num * 30) cigarettes"
            self.yearlyEst.text = "\(num * 365) cigarettes"
        } else {
            maxNumber.text = "5"
            weeklyEst.text = "35 cigarettes"
            monthlyEst.text = "150 cigarettes"
            yearlyEst.text = "1825 cigarettes"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberChanged(sender: UISlider) {
        var intValue:Int = Int(maxSlider.value)
        maxNumber.text = "\(intValue)"
        weeklyEst.text = "\(intValue*7) cigarettes"
        monthlyEst.text = "\(intValue*30) cigarettes"
        yearlyEst.text = "\(intValue*365) cigarettes"
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(intValue, forKey: "dailyMax")
        
        defaults.synchronize()
        
    }



    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
