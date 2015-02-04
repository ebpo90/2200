//
//  ViewController.swift
//  2200
//
//  Created by Eduardo Borges Pinto Osório on 2/3/15.
//  Copyright (c) 2015 Eduardo Borges Pinto Osório. All rights reserved.
//

import UIKit


import HealthKit

class ViewController: UIViewController , CountDelegate {
  
    var progress: Int = 0
    
    var kgArray = ["81","82","83","84","85"]
    
    var greenColor = UIColor(red: CGFloat(84.0/255.0), green: CGFloat(174.0/255.0), blue: CGFloat(58.0/255.0), alpha: CGFloat(1.0))
  
    var healthStore : HKHealthStore = HKHealthStore()
  
    var stepCounter : StepCounter?
  
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var lblGoal: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
  
        self.stepCounter = StepCounter(healthStore: healthStore, delegate: self);
      
    }
  
    override func viewDidAppear(animated: Bool) {
      if let count = stepCounter?.stepCount {
        countUpdated(count)
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // weightPicker configuration
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, selectedRowInComponent component: Int) -> Int {
        return 3
    }

    func pickerView(pickerView: UIPickerView!,
        numberOfRowsInComponent component: Int) -> Int {
            return kgArray.count
    }
    
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String {
        return kgArray[row]
    }
    
    func pickerView(pickerView: UIPickerView!, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = kgArray[row]
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-UltraLight", size: 20)!,NSForegroundColorAttributeName:greenColor])
        return myTitle
    }
    

  
  
    /*
     Method called every time the step counter is updated.
    */
    func countUpdated(newCount: Int) {
  
      self.lblGoal.text = "\(newCount)"
    
    }
    
}

