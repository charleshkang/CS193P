//
//  ViewController.swift
//  CalculatorAssignment
//
//  Created by Charles Kang on 7/14/16.
//  Copyright © 2016 Charles Kang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var display: UILabel!
    private var userIsInMiddleOfTypingFloatingPointNumber = false
    private var userIsInMiddleOfTyping = false {
        didSet {
            if !userIsInMiddleOfTyping {
                userIsInMiddleOfTypingFloatingPointNumber = false
            }
        }
    }
    private var brain = CalculatorBrain()
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set  {
            return display.text = String(newValue)
        }
    }
    
    @IBAction func performOperation(sender: UIButton)
    {
        if userIsInMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    @IBAction func touchDigit(sender: UIButton)
    {
        var digit = sender.currentTitle!
        
        if digit == "." {
            if userIsInMiddleOfTypingFloatingPointNumber {
                return
            }
            if !userIsInMiddleOfTyping {
                digit = "."
            }
            userIsInMiddleOfTypingFloatingPointNumber = true
        }
        
        if userIsInMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInMiddleOfTyping = true
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func restore()
    {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    @IBAction func save()
    {
        savedProgram = brain.program
    }
}