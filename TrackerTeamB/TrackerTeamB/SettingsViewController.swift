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
        var intValue:Int = Int(maxSlider.value)
        maxNumber.text = "\(intValue)"
        weeklyEst.text = "\(intValue*7)"
        monthlyEst.text = "\(intValue*30)"
        yearlyEst.text = "\(intValue*365)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberChanged(sender: UISlider) {
        var intValue:Int = Int(maxSlider.value)
        maxNumber.text = "\(intValue)"
        weeklyEst.text = "\(intValue*7)"
        monthlyEst.text = "\(intValue*30)"
        yearlyEst.text = "\(intValue*365)"
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
