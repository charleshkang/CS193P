//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Charles Kang on 7/13/16.
//  Copyright © 2016 Charles Kang. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    private var accumulator = 0.0
    private var pending: PendingBinaryOperationInfo?
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "±" : Operation.UnaryOperation({ -$0 }),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1  }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    // discrete set of values
    // similar to classes in that they can have methods. no stored vars, only computed properties, no inheritance.
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    // structs are very similar to enums. no inheritance. main difference is structs are passed by value whereas enums are passed by reference
    private struct PendingBinaryOperationInfo {
        var binaryFunction: ((Double, Double) -> Double)
        var firstOperand: Double
    }
    
    func setOperand(operand: Double)
    {
        accumulator = operand
    }
    
    func performOperation(symbol: String)
    {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
}