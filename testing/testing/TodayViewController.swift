//
//  TodayViewController.swift
//  testing
//
//  Created by Madison DeHart on 11/7/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var addition: UIButton!
    @IBOutlet weak var subtraction: UIButton!
    
    var currentCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count.text = "\(currentCount)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addOne(sender: AnyObject) {
        currentCount++
        count.text = "\(currentCount)"
    }

    @IBAction func minusOne(sender: AnyObject) {
        currentCount--
        count.text = "\(currentCount)"
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
