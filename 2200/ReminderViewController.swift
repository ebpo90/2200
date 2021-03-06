//
//  ReminderViewController.swift
//  2200
//
//  Created by Eduardo Borges Pinto Osório on 2/5/15.
//  Copyright (c) 2015 Eduardo Borges Pinto Osório. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {

    @IBAction func doneButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var reminderSwitch: UISwitch!
    
    @IBAction func toggleSwitch(sender: AnyObject) {
      
      if reminderSwitch.on {
      
        datePickerValueChanged(reminderSwitch);
        
      }
      else{
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
      
      }
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerAction(sender: AnyObject) {
      
      println("date picker called")
      
      
      if reminderSwitch.on{
        UIApplication.sharedApplication().cancelAllLocalNotifications();
        
        var selectedDate = datePicker.date;
        
        var note = UILocalNotification()
        
        note.alertBody = "Hey! Just to remind you of walking your 10000 steps today! Check out how much you've walked already!"
        note.fireDate = selectedDate;
        
        note.repeatInterval = .CalendarUnitDay
        
        UIApplication.sharedApplication().scheduleLocalNotification(note);

      }
    }

    var hourArray = [String]()


    
    let defaultUserWeight = 65
    
    let maxUserWeight = 24
    
    var userWeight = 65
    
    override func viewDidLoad() {
        super.viewDidLoad()

      // Do any additional setup after loading the view.

       datePicker.datePickerMode = UIDatePickerMode.Time;
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func datePickerValueChanged(sender:AnyObject){
    
    UIApplication.sharedApplication().cancelAllLocalNotifications();
    
    var selectedDate = datePicker.date;
    
    var note = UILocalNotification()
    
    note.alertBody = ""
    note.fireDate = selectedDate;
    
    note.repeatInterval = .CalendarUnitDay
    
    UIApplication.sharedApplication().scheduleLocalNotification(note);
    
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
