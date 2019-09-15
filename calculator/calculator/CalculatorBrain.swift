//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Vicky Kuo on 2019/8/23.
//  Copyright © 2019 Vicky Kuo. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private var accumulator = 0.0
    
    func setOperand(operand:Double){
        accumulator = operand
    }
    private var operation: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "x" : Operation.BinaryOperation({$0 * $1}),
        "➗": Operation.BinaryOperation({$0 / $1}),
        "+" :Operation.BinaryOperation({$0 + $1}),
        "-": Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals
        
    ]
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String){
        if let operation = operation[symbol]{
            switch operation{
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperation(binaryFunc:function,firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    private func executePendingBinaryOperation(){
        if pending != nil{
            accumulator = pending!.binaryFunc(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    private var pending: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        var binaryFunc: (Double,Double) -> Double
        var firstOperand:Double
    }
    var result : Double{
        get{
            return accumulator
        }
    }
}
