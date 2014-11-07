//
//  TodayViewController.swift
//  testing
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var add: UIButton!

    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count.text = "\(counter)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addToCounter(sender: UIButton) {
        counter++
        count.text = "\(counter)"
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
