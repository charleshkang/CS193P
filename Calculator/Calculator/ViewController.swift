//
//  ViewController.swift
//  Calculator
//
//  Created by Charles Kang on 7/13/16.
//  Copyright © 2016 Charles Kang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var display: UILabel!
    
    var userIsTyping = false
    
    @IBAction func touchDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        if userIsTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsTyping = true
    }
    
    @IBAction func performOperation(sender: UIButton)
    {
        userIsTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "π" {
                display.text = String(M_PI)
            }
        }
    }
}