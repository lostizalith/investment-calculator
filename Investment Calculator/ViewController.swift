//
//  ViewController.swift
//  Investment Calculator
//
//  Created by Nikita Krivitski on 6/2/19.
//  Copyright © 2019 Nikita Krivitski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var endAmount: UILabel!
    
    @IBOutlet weak var startingAmountTextField: UITextField!
    @IBOutlet weak var afterTextField: UITextField!
    @IBOutlet weak var returnRateTextField: UITextField!
    @IBOutlet weak var contributionTextField: UITextField!
    
    @IBOutlet weak var monthlyAnnualyControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startingAmountTextField.delegate = self
        afterTextField.delegate = self
        returnRateTextField.delegate = self
        contributionTextField.delegate = self
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        print("Calculate button pressed")
        closeKeyboard()
        
//        print(monthlyAnnualyControl.selectedSegmentIndex)
        
        let startingAmount = Double(startingAmountTextField.text!)
        let afterYears = Double(afterTextField.text!)
        let returnRate = Double(returnRateTextField.text!)
        let contribution = Double(contributionTextField.text!)
        
        let total = compountCalculate(initialValue: startingAmount!,
                          numberOfYears: afterYears!,
                          nominalInterest: returnRate!,
                          periodicDeposit: contribution!)
        
        print(String(format: "%.2f $", total))
        endAmount.text = String(format: "%.2f $", total)
    }
    
    func compountCalculate(initialValue: Double, numberOfYears: Double, nominalInterest: Double, periodicDeposit: Double) -> Double {
        let compoundingPeriodsPerYer = 12.0
        
        let periodicInterestRate = (nominalInterest/100.0) / compoundingPeriodsPerYer
        
        let numberOfCompoundingPeriods = numberOfYears * compoundingPeriodsPerYer
        
        let initalPart = initialValue * pow(periodicInterestRate + 1, numberOfCompoundingPeriods)
        let nextPart = periodicDeposit * ((pow(periodicInterestRate + 1, numberOfCompoundingPeriods) - 1) / periodicInterestRate) * (1 + periodicInterestRate)
        
        let total = initalPart + nextPart
        
        return total
    }
    
    func closeKeyboard() {
        startingAmountTextField.resignFirstResponder()
        afterTextField.resignFirstResponder()
        returnRateTextField.resignFirstResponder()
        contributionTextField.resignFirstResponder()
    }
    
    // UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeKeyboard()
        
        return true
    }
}
