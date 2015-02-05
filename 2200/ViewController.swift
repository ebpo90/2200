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
    
    var kgArray = [String]()
    
    var greenColor = UIColor(red: CGFloat(84.0/255.0), green: CGFloat(174.0/255.0), blue: CGFloat(58.0/255.0), alpha: CGFloat(1.0))
  
    var healthStore : HKHealthStore = HKHealthStore()
  
    var stepCounter : StepCounter?
    
    let defaultUserWeight = 65
    
    let maxUserWeight = 150
    
    var userWeight = 65
  
    @IBOutlet weak var weightPicker: UIPickerView!
  
    @IBOutlet weak var lblGoal: UILabel!
    
    @IBOutlet weak var lblSteps: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadWeightArray()
        self.selectUserWeight()
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
    
    func pickerView(pickerView: UIPickerView!,
        numberOfRowsInComponent component: Int) -> Int {
            return kgArray.count
    }
    
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String {
        return kgArray[row]
    }
    
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView
    {
        var pickerLabel = UILabel()
        pickerLabel.textColor = greenColor
        pickerLabel.text = kgArray[row]
        // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
        pickerLabel.font = UIFont(name: "HelveticaNeue-Light", size: 30) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func selectedRowInComponent(component: Int) -> Int {
        var pos = -1
        var count = 0
        
        for (var i = defaultUserWeight; i <= maxUserWeight && pos == -1 ; i++, count++)
        {
            if (i == userWeight)
            {
                pos = count
            }
        }
        return pos
    }


  
    /*
     Method called every time the step counter is updated.
    */
    func countUpdated(newCount: Int) {
  
      self.lblGoal.text = "\(newCount)"
    
    }
    
    func loadWeightArray() {
        for (var i = defaultUserWeight; i <= maxUserWeight; i++)
        {
            kgArray.append(String(i));
        }
    }
    
    func selectUserWeight() {
        let past : NSDate = NSDate.distantPast() as NSDate
        let now = NSDate()
        let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(past, endDate: now, options: HKQueryOptions.None)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false);
        let idWeight = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        let sampleQuery = HKSampleQuery(sampleType: idWeight, predicate: mostRecentPredicate, limit: 0, sortDescriptors: [sortDescriptor], resultsHandler:
            {(_,results,_) -> Void in
                
                if (results != nil) {
                    let sample = results.first as HKQuantitySample
                    let quantity = sample.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo))
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.userWeight = Int(quantity)
                        self.weightPicker.selectRow(self.selectedRowInComponent(0), inComponent: 0, animated: false)
                        
                    })
                }
        })
        
        healthStore.executeQuery(sampleQuery)
    }
}

