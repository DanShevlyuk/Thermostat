//
//  CopyScheduleViewController.swift
//  Thermostat
//
//  Created by Dan K. on 2015-08-29.
//  Copyright (c) 2015 Team #19. All rights reserved.
//

import UIKit

class CopyScheduleViewController: UITableViewController {
    
    var dayProgram: DayProgram!
    var dayOfTheWeek: Int!
    
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var daysToCopy = [false, false, false, false, false, false, false]

    override func viewDidLoad() {
        super.viewDidLoad()

        dayOfTheWeek =  dayOfTheWeek == 0 ? 6 : dayOfTheWeek - 1
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekdays.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DayCell", forIndexPath: indexPath)

        cell.accessoryType = daysToCopy[indexPath.row] ? .Checkmark : .None
        cell.textLabel?.text = weekdays[indexPath.row]

        if indexPath.row == dayOfTheWeek {
            cell.backgroundColor = UIColor(white: 0.84, alpha: 1.0)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != dayOfTheWeek {
            daysToCopy[indexPath.row] = !daysToCopy[indexPath.row]
            tableView.reloadData()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    @IBAction func copySchedule(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let okActionHandler = { (_: UIAlertAction!) -> Void in
            for (index, dayToCopy) in self.daysToCopy.enumerate() {
                if dayToCopy == true {
                    let day = index == 6 ? 0 : index + 1
                    Thermostat.sharedInstance.program.days[day] = self.dayProgram.copy() as! DayProgram
                }
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }

        if appDelegate.settings.showCopyScheduleAlert {
            let alert = UIAlertController(title: "Warning!", message: "The schedule of the selected days will be replaced with the current schedule.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: okActionHandler))
            alert.addAction(UIAlertAction(title: "Don't show this again", style: .Default, handler: { (_) -> Void in
                appDelegate.settings.showCopyScheduleAlert = false
                okActionHandler(nil)
            }))
            presentViewController(alert, animated: true, completion: nil)
        } else {
            okActionHandler(nil)
        }

    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
