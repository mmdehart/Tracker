//
//  TodayViewController.swift
//  TrackerTeamB
//
//  Created by Madison DeHart on 11/6/14.
//  Copyright (c) 2014 Madison DeHart. All rights reserved.
//

import UIKit
import Foundation

class TodayViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var timeSince: UILabel!
    
    var appDelegate:AppDelegate!
    
    let dateFormatter = NSDateFormatter()
    //let timeFormatter = NSDateFormatter() ???maybe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = NSDate()
        
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        todayDate.text = dateFormatter.stringFromDate(today)

        countLabel.text = "\(appDelegate.getTodayCount())"
        
        if appDelegate.getTotalCigCount() != 0 {

            var timesince = appDelegate.getTimeSinceLast()
            timeSince.text = "\(timesince)"
        }
        else {
            timeSince.text = "0"

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func plusButtonPressed(sender: UIButton) {
        if appDelegate.getTotalCigCount() != 0 {
            var timesince = appDelegate.getTimeSinceLast()
            timeSince.text = "\(timesince)"
        }
        appDelegate.addCig()
        
        countLabel.text = "\(appDelegate.getTodayCount())"
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        (segue.destinationViewController as EditTableViewController).detailItems = cigarettes
//        
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    
//    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    RecipeDetailViewController *destViewController = segue.destinationViewController;
//    destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
//    
//    // Hide bottom tab bar in the detail view
//    destViewController.hidesBottomBarWhenPushed = YES;
//    }
//    }
}
