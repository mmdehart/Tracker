//
//  ViewController.swift
//  testSegmentedView
//
//  Created by Madison DeHart on 11/9/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var segControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textLabel.text = "First selected"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
            case 0:
                textLabel.text = "First selected"
            case 1:
                textLabel.text = "Second Segment selected"
            case 2:
                textLabel.text = "Third Segment selected"
            case 3:
                textLabel.text = "Fourth Segment selected"
            default:
                break;
        }
        
    }

}

