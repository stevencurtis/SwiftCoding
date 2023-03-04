//
//  ContentView.swift
//  Calculator
//
//  Created by Steven Curtis on 19/02/2023.
//

import SwiftUI

struct ContentView: View {
    // a body var that returns a 0-9 View containing a keypad and a +, linking to the Calculator
    @State private var brain = Calculator()
    @State private var userIsInTheMiddleOfTyping = false
    @State private var display = "0"

    var body: some View {
        VStack {
            Text(display)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .font(.system(size: 64))
            HStack {
                Button("AC") {
                    display = "0"
                }
                Button("±") {
                    if let operand = brain.operands.first {
                        brain.operands[0] = -operand
                    }
                }
                Button("%") {
                    if let operand = brain.operands.first {
                        brain.operands[0] = operand / 100
                    }
                }
                Button("÷") {
                    display = String(brain.performOperation("÷") ?? 0)
                }
            }
            .padding()
            HStack {
                Button("7") {
                    display = String(brain.pushOperand(7) ?? 0)
                }
                Button("8") {
                    display = String(brain.pushOperand(8) ?? 0)
                }
                Button("9") {
                    display = String(brain.pushOperand(9) ?? 0)
                }
                Button("×") {
                    display = String(brain.performOperation("×") ?? 0)
                }
            }
            .padding()
            HStack {
                Button("4") {
                    display = String(brain.pushOperand(4) ?? 0)
                }
                Button("5") {
                    display = String(brain.pushOperand(5) ?? 0)
                }
                Button("6") {
                    display = String(brain.pushOperand(6) ?? 0)
                }
                Button("-") {
                    display = String(brain.performOperation("-") ?? 0)
                }
            }
            .padding()
            HStack {
                Button("1") {
                    display = String(brain.pushOperand(1) ?? 0)
                }
                Button("2") {
                    display = String(brain.pushOperand(2) ?? 0)
                }
                Button("3") {
                    display = String(brain.pushOperand(3) ?? 0)
                }
                Button("+") {
                    
                    display = String(brain.performOperation("+") ?? 0)
                }
            }
            .padding()
            HStack {
                Button("0") {
                    brain.pushOperand(0)
                }
                Button(".") {
                    if !display.contains(".") {
                        display += "."
                    }
                }
                Button("=") {
                    display = String(brain.performOperation("=") ?? 0)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
