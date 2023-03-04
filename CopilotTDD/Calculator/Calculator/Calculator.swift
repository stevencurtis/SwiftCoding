//
//  Calculator.swift
//  Calculator
//
//  Created by Steven Curtis on 17/02/2023.
//

import Foundation

final class Calculator {
    var operands: [Double] = []
    var opCode: String? = nil
    func pushOperand(_ operand: Double) -> Double? {
        operands.append(operand)
        return evaluate()
    }

    func performOperation(_ operation: String) -> Double? {
        opCode = operation
        return evaluate()
    }
    
    private func evaluate() -> Double? {
        guard operands.count == 2 else {
            return operands.first
        }
        return convertOpCodeToFunction(opCode ?? "+")(operands[0], operands[1])
    }

    // private function to convert String opCode to a function
    private func convertOpCodeToFunction(_ opCode: String) -> (Double, Double) -> Double {
        switch opCode {
        case "+":
            return (+)
        case "-":
            return (-)
        case "*":
            return (*)
        case "/":
            return (/)
        default:
            return (+)
        }
    }
}
