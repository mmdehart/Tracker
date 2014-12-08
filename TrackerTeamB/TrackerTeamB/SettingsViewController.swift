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
    
    var appDelegate:AppDelegate!
//    var settings:SettingsData!
    var model : cloudKitData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        model = appDelegate.getCloudData()
        // get the mapdata
//        settings = appDelegate.getSetData()

        if(model.maxGoal > 0) {
            maxSlider.value = Float(model.maxGoal)
            maxNumber.text = "\(model.maxGoal)"
            weeklyEst.text = "\(model.maxGoal * 7) cigarettes"
            monthlyEst.text = "\(model.maxGoal * 30) cigarettes"
            yearlyEst.text = "\(model.maxGoal * 365) cigarettes"
        }
//        settings.dailyMax = intValue
        // Do any additional setup after loading the view.
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
        
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // get the mapdata
//        settings = appDelegate.getSetData()
        
//        settings.dailyMax = intValue
    }

    @IBAction func sliderStopped(sender: UISlider) {
        model.saveGoal(Int(sender.value))
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
