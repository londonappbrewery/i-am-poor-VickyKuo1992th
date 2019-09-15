//
//  ViewController.swift
//  calculator
//
//  Created by Vicky Kuo on 2019/8/21.
//  Copyright © 2019 Vicky Kuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
            super.viewDidLoad()
        let background = UIColor(red:0,green: 55, blue: 170, alpha:1)
    }
    
    private var brain = CalculatorBrain()
    @IBAction private func performOperation(_ sender: UIButton) {
        if userInTheMiddleOfTyping{
            brain.setOperand(operand: displayValue)
            userInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{ //这种写法防止崩溃{
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
        
        
    }
    
    private var displayValue:Double{
        get{
            return Double(display.text!) as! Double
        }
        set{
            display.text = String(newValue)
        }
    }

    @IBAction private func button(_ sender: UIButton) {
        let digit = sender.currentTitle! //容易是程序崩溃。Optional类型
        if userInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userInTheMiddleOfTyping = true
    }
    
    @IBOutlet private weak var display: UILabel!
     var userInTheMiddleOfTyping = false


}
